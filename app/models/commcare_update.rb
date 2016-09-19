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
    errors.add(:morpho_sql, "Veuillez sélectionner un fichier") if morpho_sql.nil?
    # day = @commcare_update.cc_update_on.strftime("%Y-%m-%d")
    # upload = params[:commcare_update][:morpho_sql]
    #
    # create_daily_repo day
    # save_morpho_sql upload, day
    # copy_morpho_sql_to_mqi upload

    # Seed Database
      # Check data in file is actually of the correct date (today)
      # Check import worked


    # Create XLS with new participants
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

  def save_morpho_sql upload, day
    filename = "#{day}-#{MORPHO_SQL_FILENAME}"
    FileUtils.cp upload.tempfile, "#{UPDATES_PATH}/#{day}/#{filename}"
  end

  def copy_morpho_sql_to_mqi upload
    FileUtils.cp upload.tempfile, "#{MQI_PATH}/db/#{MQI_STRUCTURE_FILENAME}"
  end

end
