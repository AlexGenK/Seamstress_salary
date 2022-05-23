class PersonalsController < ApplicationController
  before_action :set_bonus
  before_action :set_personal, only: [:destroy]

  def index
    @personals = @bonus.personals.order(:user_name)
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
end
