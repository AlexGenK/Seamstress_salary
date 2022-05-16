class VisitsController < ApplicationController
  before_action :set_timesheet

  def index
    @visits = @timesheet.visits.order(:user_name)
  end

  private

  def set_timesheet
    @timesheet = Timesheet.find(params[:timesheet_id])
  end
end
