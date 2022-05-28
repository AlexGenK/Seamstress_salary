class PersonalsController < ApplicationController
  before_action :set_bonus
  before_action :set_personal, only: [:destroy, :edit, :update]
  after_action :recalculate_bonus_sum, only: [:destroy, :update]
  load_and_authorize_resource

  def index
    @personals = @bonus.personals.order(:user_name)
    @page = session[:page]
  end

  def edit
  end

  def update
    if @personal.update(personal_params)      
      redirect_to bonus_personals_path(@bonus)
    else
      flash[:alert] = 'Невозможно отредактировать коэффициент'
      render :edit
    end
  end

  def destroy
    flash[:alert] = 'Невозможно удалить коэффициент' unless @personal.destroy
    redirect_to bonus_personals_path(@bonus)
  end

  private

  def set_bonus
    @bonus = Bonus.find(params[:bonus_id])
  end

  def set_personal
    @personal = Personal.find(params[:id])
  end

  def personal_params
    params.require(:personal).permit(:user_name, :report_time, :timesheet_time, :execution, :factor)
  end

  def recalculate_bonus_sum
    @bonus.calculate_sum
  end
end
