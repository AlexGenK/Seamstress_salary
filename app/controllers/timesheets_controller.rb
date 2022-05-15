class TimesheetsController < ApplicationController
  before_action :set_timesheet, only: [:destroy]

  def index
    @timesheets = Timesheet.order(date: :desc)
    @timesheet = Timesheet.new(date: Date.today)
  end

  def create
    @timesheet = Timesheet.new(timesheet_params)
    flash[:alert] = 'Невозможно добавить табель' unless @timesheet.save
    redirect_to timesheets_path
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
