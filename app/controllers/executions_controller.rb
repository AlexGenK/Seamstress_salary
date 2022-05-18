class ExecutionsController < ApplicationController
  before_action :set_production
  before_action :set_work
  
  def index
    @executions = @work.executions.all
  end

  private

  def set_production
    @production = Production.find(params[:production_id])
  end

  def set_work
    @work = Work.find(params[:work_id])
  end
end
