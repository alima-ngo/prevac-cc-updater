class CommcareUpdate < ApplicationRecord
  attr_accessor :morpho_sql

  validate :validate_step1, if: "!id.nil? and progress == 1"

  MAX_STEPS = 5
  COMPLETION_STEP = MAX_STEPS + 1

  UPDATES_PATH = "public/updates"
  MORPHO_SQL_FILENAME = "morpho-db.sql"
  MQI_PATH = "../prevac-morpho-query-interface"
  MQI_STRUCTURE_FILENAME = "structure.sql"

  require 'fileutils'

  def self.on_going_update?
    a = CommcareUpdate.where("cc_update_on = :date AND progress < :completion_step", {date: Date.today, completion_step: COMPLETION_STEP})
    a.size == 1
  end

  def is_current?
    cc_update_on == Date.today and progress != COMPLETION_STEP
  end

  def validate_step1
    #errors.add(:base, "error message")
    if morpho_sql.nil?
      errors.add(:morpho_sql, "Veuillez sélectionner un fichier")
      return
    end

    day = cc_update_on.strftime("%Y-%m-%d")
    create_daily_repo(day)
    save_morpho_sql(morpho_sql, day)
    copy_morpho_sql_to_mqi(morpho_sql)
    system("./bin/migrate_mqi.sh")

    # Check import worked
    # Create XLS with new participants

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

end
