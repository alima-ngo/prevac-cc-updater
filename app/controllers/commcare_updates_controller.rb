class CommcareUpdatesController < ApplicationController
  before_action :set_commcare_update, only: [:show, :edit, :update, :destroy]

  def index
    @commcare_updates = CommcareUpdate.order(cc_update_on: 'desc').paginate(:page => params[:page], per_page: 7)
  end

  def show
  end

  def new
    @commcare_update = CommcareUpdate.new
  end

  def edit
  end

  def create
    @commcare_update = CommcareUpdate.new(commcare_update_params)

    respond_to do |format|
      if @commcare_update.save
        format.html { redirect_to @commcare_update, notice: 'CommcareUpdate was successfully created.' }
        format.json { render :show, status: :created, location: @commcare_update }
      else
        format.html { render :new }
        format.json { render json: @commcare_update.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @commcare_update.update(commcare_update_params)
        format.html { redirect_to @commcare_update, notice: 'CommcareUpdate was successfully updated.' }
        format.json { render :show, status: :ok, location: @commcare_update }
      else
        format.html { render :edit }
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
    # Use callbacks to share common setup or constraints between actions.
    def set_commcare_update
      @commcare_update = CommcareUpdate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def commcare_update_params
      params.require(:commcare_update).permit(:name)
    end

end
