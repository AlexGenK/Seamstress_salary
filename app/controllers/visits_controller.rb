class VisitsController < ApplicationController
  before_action :set_timesheet
  before_action :set_visit, only: [:destroy]

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
    @timesheet.calculate_sum
    redirect_to timesheet_visits_path(@timesheet)
  end

  def new
    @user_names = User.where({worker_role: true}).order(:name).pluck(:name)
    @visit = @timesheet.visits.new
  end

  def create
    unless Visit.find_by(timesheet_id: @timesheet.id, user_name: visit_params[:user_name]) == nil
      flash[:alert] = 'Невозможно добавить уже существующего в табеле сотрудника'
      redirect_to timesheet_visits_path(@timesheet)
      return
    end
    @visit = @timesheet.visits.new(visit_params)
    if @visit.save
      @timesheet.calculate_sum
      redirect_to timesheet_visits_path(@timesheet)
    else
      flash[:alert] = 'Невозможно добавить сотрудника'
      render :new
    end
  end

  def destroy
    flash[:alert] = 'Невозможно удалить сведения' unless @visit.destroy
    @timesheet.calculate_sum
    redirect_to timesheet_visits_path(@timesheet)
  end

  private

  def visit_params
    params.require(:visit).permit(:user_name, :time)
  end

  def set_timesheet
    @timesheet = Timesheet.find(params[:timesheet_id])
  end

  def set_visit
    @visit = Visit.find(params[:id])
  end
end
