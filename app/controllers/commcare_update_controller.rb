class CommcareUpdateController < ApplicationController
  def index
    @updates = CommcareUpdate.order(cc_update_on: 'desc').paginate(:page => params[:page], per_page: 7)
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
end
