class CommcareUpdate < ApplicationRecord
  require 'fileutils'

  scope :last_successful_morpho_import, -> { where("progress > 1").order(cc_update_on: :desc).limit(1).first.cc_update_on.strftime("%Y-%m-%d") }
  scope :last_successful_new_participant_import, -> { where("progress > 2").order(cc_update_on: :desc).limit(1).first.cc_update_on.strftime("%Y-%m-%d") }

  attr_accessor :morpho_sql

  validate :validate_steps, on: :update

  MAX_STEPS = 5
  COMPLETION_STEP = MAX_STEPS + 1

  UPDATES_PATH = "public/updates"
  MORPHO_SQL_FILENAME = "morpho-db.sql"
  MQI_PATH = "../prevac-morpho-query-interface"
  MQI_STRUCTURE_FILENAME = "structure.sql"

  NEW_PARTICIPANTS_BASENAME = "new_participants"
  NEW_REMINDERS_BASENAME = "new_reminders"

  def self.on_going_update?
    a = CommcareUpdate.where("cc_update_on = :date AND progress < :completion_step", {date: Date.today, completion_step: COMPLETION_STEP})
    a.size == 1
  end

  def is_current?
    cc_update_on == Date.today and progress != COMPLETION_STEP
  end

  def validate_steps
    case self.progress
      when 1
        validate_step1
      when 2
        validate_step2
      when 3
        validate_step3
      when 4
        validate_step4
      when 5
        validate_step5
    end
  end

  def validate_step1
    if morpho_sql.nil?
      errors.add(:morpho_sql, "Veuillez sélectionner un fichier")
      return
    end

    day = cc_update_on.strftime("%Y-%m-%d")
    create_daily_repo(day)
    save_morpho_sql(morpho_sql, day)
    copy_morpho_sql_to_mqi(morpho_sql)

    d1 = get_last_migration_date
    system("./bin/migrate_mqi.sh")
    d2 = get_last_migration_date

    if !d1.nil? and !d2.nil? and d1 >= d2
      errors.add(:base, "Migration MQI echouée")
      return
    end

    r = has_new_data?
    if r.nil?
      return
    end

    if r == false and false # DEBUG: and false
      errors.add(:base, "Le fichier d'import ne comporte pas de nouvelles données")
      return
    end

    participants = ExcelExporter.create_new_participants_reminders_xls(self)

    self.new_pids = participants.map { |p| p.PID }.join(",")
    self.progress = 2
  end

  def validate_step2
    self.progress = 3
  end

  def validate_step3
    self.progress = 4
  end

  def validate_step4
    self.progress = 5
  end

  def validate_step5
    self.progress = 6
  end

  def new_participants_file_path ext
    day = cc_update_on.strftime("%Y-%m-%d")
    "#{UPDATES_PATH}/#{day}/#{day}-#{NEW_PARTICIPANTS_BASENAME}.#{ext}"
  end

  def new_reminders_file_path ext
    day = cc_update_on.strftime("%Y-%m-%d")
    "#{UPDATES_PATH}/#{day}/#{day}-#{NEW_REMINDERS_BASENAME}.#{ext}"
  end

  private

  def create_daily_repo day
    FileUtils.mkdir "#{UPDATES_PATH}/#{day}" if !Dir.exist? "#{UPDATES_PATH}/#{day}"
  end

  def save_morpho_sql sql_upload, day
    filename = "#{day}-#{MORPHO_SQL_FILENAME}"
    FileUtils.cp sql_upload.tempfile, "#{UPDATES_PATH}/#{day}/#{filename}"
  end

  def copy_morpho_sql_to_mqi sql_upload
    FileUtils.cp sql_upload.tempfile, "#{MQI_PATH}/db/#{MQI_STRUCTURE_FILENAME}"
  end

  def get_last_migration_date
    begin
      r = HTTP.get("#{ApplicationController::MQI_URL}/queries/last_migration")
    rescue => e
      errors.add(:base, "Erreur pendant la requête \"date de dernière migration (last_migration)\" : #{e}")
      return nil
    end
    DateTime.parse(r.body)
  end

  def has_new_data?
    since = CommcareUpdate.last_successful_morpho_import
    begin
      r = HTTP.get("#{ApplicationController::MQI_URL}/queries/has_new_data/#{since}")
    rescue => e
      errors.add(:base, "Erreur pendant la requête \"nouvelles données (has_new_data)\" : #{e}")
      return nil
    end
    r.body == "true"
  end
end
