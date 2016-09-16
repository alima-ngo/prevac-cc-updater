class CommcareUpdatesController < ApplicationController
  before_action :set_commcare_update, except: [:index, :new, :create]
  before_action :check_on_going_update, only: [:new, :create]

  require 'fileutils'

  def index
    @commcare_updates = CommcareUpdate.order(cc_update_on: 'desc').paginate(:page => params[:page], per_page: 7)
  end

  def show
  end

  def new
    @commcare_update = CommcareUpdate.new
  end

  def edit
    @step = params[:step]
  end

  def create
    @commcare_update = CommcareUpdate.new(commcare_update_params)

    respond_to do |format|
      if @commcare_update.save
        format.html { redirect_to step_commcare_update_path(@commcare_update, step: 1), notice: 'CommcareUpdate was successfully created.' }
        format.json { render :show, status: :created, location: @commcare_update }
      else
        format.html { render :new }
        format.json { render json: @commcare_update.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @step = @commcare_update.progress - 1 # In case of error
    eval("step#{@step}")
    respond_to do |format|
      if @commcare_update.update(commcare_update_params)
        format.html { redirect_to step_commcare_update_path(@commcare_update, step: @commcare_update.progress), notice: 'CommcareUpdate was successfully updated.' }
        format.json { render :show, status: :ok, location: @commcare_update }
      else
        format.html { render :edit, step: @commcare_update.progress - 1 }
        format.json { render json: @commcare_update.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reports/1
  # DELETE /reports/1.json
  def destroy
    @commcare_update.destroy
    respond_to do |format|
      format.html { redirect_to reports_url, notice: 'CommcareUpdate was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def step1
    # Check data in file is actually of the correct date (today)

    # Save file to repository
    f = params[:commcare_update][:morpho_sql]
    dir_name = @commcare_update.cc_update_on.strftime("%Y-%m-%d")
    dir_path = "#{CommcareUpdate::UPDATES_PATH}/#{dir_name}"
    fname = "#{dir_name}-#{CommcareUpdate::MORPHO_SQL_FILENAME}"
    FileUtils.mkdir dir_path
    FileUtils.cp f.tempfile, "#{dir_path}/#{fname}"

    # Seed Database
    FileUtils.cp f.tempfile, "#{dir_path}/#{CommcareUpdate::MQI_STRUCTURE_FILENAME}"

      # Check import worked


    # Create XLS with new participants
  end

  def step2
  end

  def step3
  end

  def step4
  end

  def step5
  end

  private
    def check_on_going_update
      if CommcareUpdate.on_going_update?
        redirect_to root_path, alert: 'Il y a déjà une mise à jour en cours aujourd\'hui'
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_commcare_update
      @commcare_update = CommcareUpdate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def commcare_update_params
      params.require(:commcare_update).permit(:progress, :cc_update_on, :active, :morpho_sql)
    end

end