class TimesheetsController < ApplicationController
  before_action :set_timesheet, only: [:destroy]
  load_and_authorize_resource

  def index
    @pagy, @timesheets = pagy(Timesheet.order(date: :desc))
    @timesheet = Timesheet.new(date: Date.today)
    session[:page] = @pagy.page
  end

  def create
    @timesheet = Timesheet.new(timesheet_params)
    if Timesheet.get_by_my(@timesheet.date) != nil
      redirect_to timesheets_path(page: session[:page]), alert: 'Табель за этот месяц уже существует!'
      return
    end
    flash[:alert] = 'Невозможно добавить табель' unless @timesheet.save
    redirect_to mass_new_timesheet_visits_path(@timesheet)
  end

  def destroy
    flash[:alert] = 'Невозможно удалить табель' unless @timesheet.destroy
    redirect_to timesheets_path(page: session[:page])
  end

  private

  def timesheet_params
    params.require(:timesheet).permit(:date)
  end

  def set_timesheet
    @timesheet = Timesheet.find(params[:id])
  end
end
