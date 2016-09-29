class CommcareUpdatesController < ApplicationController
  before_action :check_mqi_status, except: [:index, :show]
  before_action :set_commcare_update, except: [:index, :new, :create]
  before_action :check_on_going_update, only: [:new, :create]

  def index
    @commcare_updates = CommcareUpdate.order(cc_update_on: 'desc').paginate(:page => params[:page], per_page: 7)
  end

  def show
  end

  def new
    @commcare_update = CommcareUpdate.new
  end

  def edit
    if !@commcare_update.is_current?
      redirect_to root_path, alert: "Cette mise à jour est close"
    end
    @current_step = params[:step]
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
    @current_step = @commcare_update.progress
    respond_to do |format|
      if @commcare_update.update(commcare_update_params)
        format.html { redirect_to step_commcare_update_path(@commcare_update, step: @commcare_update.progress), notice: "Etape #{@commcare_update.progress - 1} validée avec succès"  }
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

  def new_participants_file
    send_file @commcare_update.new_participants_file_path
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
      params.require(:commcare_update).permit(:progress, :cc_update_on, :active, :morpho_sql, :new_pids)
    end

    def check_mqi_status
      if @mqi_status == "ko"
        redirect_to root_path, alert: "L'application MQI ne fonctionne pas. Veuillez rédemarrer la machine et/ou contacter le Responsable IT."
      end
    end
end
