class CommcareUpdate < ApplicationRecord
  scope :last_successful_morpho_import, -> { where("progress > 1").order(cc_update_on: :desc).limit(1).first.cc_update_on.strftime("%Y-%m-%d") }
  scope :last_successful_new_participant_import, -> { where("progress > 2").order(cc_update_on: :desc).limit(1).first.cc_update_on.strftime("%Y-%m-%d") }

  attr_accessor :morpho_sql

  validate :validate_step1, if: "!id.nil? and progress == 1"
  validate :validate_step2, if: "!id.nil? and progress == 2"

  MAX_STEPS = 5
  COMPLETION_STEP = MAX_STEPS + 1

  UPDATES_PATH = "public/updates"
  MORPHO_SQL_FILENAME = "morpho-db.sql"
  MQI_PATH = "../prevac-morpho-query-interface"
  MQI_STRUCTURE_FILENAME = "structure.sql"

  EMPTY_EXCEL_FILENAME = "bin/empty-excel-file.xls"
  NEW_PARTICIPANTS_FILENAME = "new_participants.xls"

  require 'fileutils'

  def self.on_going_update?
    a = CommcareUpdate.where("cc_update_on = :date AND progress < :completion_step", {date: Date.today, completion_step: COMPLETION_STEP})
    a.size == 1
  end

  def is_current?
    cc_update_on == Date.today and progress != COMPLETION_STEP
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

    create_new_participants_xls

    self.progress = 2
  end

  def validate_step2
  end

  def validate_step3
  end

  def validate_step4
  end

  def validate_step5
  end

  def new_participant_file_path
    day = cc_update_on.strftime("%Y-%m-%d")
    "#{UPDATES_PATH}/#{day}/#{day}-#{NEW_PARTICIPANTS_FILENAME}"
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
    rescue
      errors.add(:base, "Erreur pendant la requête : date de dernière migration (last_migration)")
      return nil
    end
    DateTime.parse(r.body)
  end

  def has_new_data?
    since = CommcareUpdate.last_successful_morpho_import
    begin
      r = HTTP.get("#{ApplicationController::MQI_URL}/queries/has_new_data/#{since}")
    rescue
      errors.add(:base, "Erreur pendant la requête : nouvelles données (has_new_data)")
      return nil
    end
    r.body == "true"
  end

  def create_new_participants_xls
    since = CommcareUpdate.last_successful_new_participant_import
    begin
      morpho_fields = {
        pid: "PID",
        nom: "Full_Name",
        telephone_1: "Phone_Number_1"
      }

      r = HTTP.get("#{ApplicationController::MQI_URL}/queries/new_participants/2016-01-01")
      participants = JSON.parse(r.body, object_class: OpenStruct)

      Spreadsheet.client_encoding = 'UTF-8'
      book = Spreadsheet.open(EMPTY_EXCEL_FILENAME)
      sheet1 = book.worksheets.first

      # header row: morpho data + other data
      sheet1.row(0).concat morpho_fields.keys.map { |k| k.to_s }

      # participant row: morpho data + other data
      participants.each do |p|
        x = []
        morpho_fields.each { |k, v| x.push p.send(v) }
        sheet1.row(sheet1.row_count).concat x
      end

      # file
      book.write new_participant_file_path
    rescue
      errors.add(:base, "Erreur pendant la requête : nouveaux participatns (new_participants)")
      return nil
    end
    true
  end

end
