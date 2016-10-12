class CommcareUpdate < ApplicationRecord
  require 'fileutils'

  scope :last_successful_morpho_import, -> { where("progress > 1").order(cc_update_on: :desc).limit(1).first.cc_update_on.strftime("%Y-%m-%d") }
  scope :last_successful_new_participant_import, -> { where("progress > 2").order(cc_update_on: :desc).limit(1).first.cc_update_on.strftime("%Y-%m-%d") }
  scope :last_successful_new_reminder_import, -> { where("progress > 3").order(cc_update_on: :desc).limit(1).first.cc_update_on.strftime("%Y-%m-%d") }

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

    data = ExcelExporter.create_new_participants_reminders_xls(self)

    self.new_participants = data[:participants].map { |p| {"pid" => p.PID} }.to_json
    self.new_reminders = data[:reminders].map { |r| {"case_name" => r} }.to_json
    self.progress = 2
  end

  def validate_step2 # check if import of new participants worked
    received_cases = []
    imported_cases = []
    not_imported_pids = []

    ccc = CommcareApi::CommcareConnector.new("guinee.respit.prevac@alima-ngo.org", "suffer.dublin.summer")
    r = ccc.get_cases("prevac-1", type: "prevac-participant", server_date_modified_start: CommcareUpdate.last_successful_new_participant_import, limit: 100)
    while !r.nil? do
      j = JSON.parse(r.body)
      j["objects"].each { |o| received_cases.push({case_id: o["case_id"], pid: o["properties"]["case_name"]}) }
      r = ccc.get_next_data
    end

    imported_pids = JSON.parse(self.new_participants).map { |e| e["pid"] }
    imported_pids.each do |pid|
      found = false
      received_cases.each do |c|
        if pid == c[:pid]
          imported_cases.push c
          found = true
          break
        end
      end
      not_imported_pids.push pid if !found
    end

    if not_imported_pids.size > 0
      errors.add(:base, "L'import a échoué pour #{not_imported_pids.size} participant(s) : #{not_imported_pids.join(", ")}")
      return
    end

    self.new_participants = imported_cases.to_json
    self.progress = 3
  end

  def validate_step3 # check if import of new reminders worked
    received_reminders = []
    imported_reminders = []
    not_imported_reminders = []

    ccc = CommcareApi::CommcareConnector.new("guinee.respit.prevac@alima-ngo.org", "suffer.dublin.summer")
    r = ccc.get_cases("prevac-1", type: "rappel", server_date_modified_start: CommcareUpdate.last_successful_new_reminder_import, limit: 100)
    while !r.nil? do
      j = JSON.parse(r.body)
      j["objects"].each do |o|
        received_reminders.push({case_id: o["case_id"], case_name: o["properties"]["case_name"]})
      end
      r = ccc.get_next_data
    end

    expected_reminders = JSON.parse(self.new_reminders).map {|e| e["case_name"]}
    expected_reminders.each do |r|
      found = false
      received_reminders.each do |e|
        if r == e[:case_name]
          imported_reminders.push e
          found = true
          break
        end
      end
      not_imported_reminders.push r if !found
    end

    if not_imported_reminders.size > 0
      errors.add(:base, "L'import a échoué pour #{not_imported_reminders.size} rappel(s) : #{not_imported_reminders.join(", ")}")
      return
    end

    self.new_reminders = imported_reminders.to_json

    # Create XLS to update participant visit status and exluded participants

    self.progress = 4
  end

  def validate_step4
    # Validate update
    # Create XLS to update existing reminders and add the ones for J63 and J70 if needed
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
