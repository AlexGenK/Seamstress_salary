class VisitsController < ApplicationController
  before_action :set_timesheet

  def index
    @visits = @timesheet.visits.order(:user_name)
  end

  def mass_new
    @users = User.where({worker_role: true}).order(:name)
  end

  def mass_create
    params[:visits].each do |params|
      @timesheet.visits.create(user_name: params[:user_name], time: params[:time].to_i)
    end
    redirect_to timesheet_visits_path(@timesheet)
  end

  private

  def set_timesheet
    @timesheet = Timesheet.find(params[:timesheet_id])
  end
end
