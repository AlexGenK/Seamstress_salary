class TimesheetsController < ApplicationController
  before_action :set_timesheet, only: [:destroy]
  load_and_authorize_resource

  def index
    @timesheets = Timesheet.order(date: :desc)
    @timesheet = Timesheet.new(date: Date.today)
  end

  def create
    @timesheet = Timesheet.new(timesheet_params)
    flash[:alert] = 'Невозможно добавить табель' unless @timesheet.save
    redirect_to mass_new_timesheet_visits_path(@timesheet)
  end

  def destroy
    flash[:alert] = 'Невозможно удалить табель' unless @timesheet.destroy
    redirect_to timesheets_path
  end

  private

  def timesheet_params
    params.require(:timesheet).permit(:date)
  end

  def set_timesheet
    @timesheet = Timesheet.find(params[:id])
  end
end
