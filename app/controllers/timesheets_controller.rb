class TimesheetsController < ApplicationController
  def index
    @timesheets = Timesheet.order(date: :desc)
    @timesheet = Timesheet.new(date: Date.today)
  end

  def create
    @timesheet = Timesheet.new(timesheet_params)
    flash[:alert] = 'Невозможно добавить модель' unless @timesheet.save
    redirect_to timesheets_path
  end

  private

  def timesheet_params
    params.require(:timesheet).permit(:date)
  end
end
