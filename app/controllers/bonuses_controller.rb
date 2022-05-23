class BonusesController < ApplicationController
  before_action :set_bonus, only: [:destroy]

  def index
    @bonus = Bonus.new(date: Date.today)
    @bonuses = Bonus.order(:date)
  end

  def create
    @bonus = Bonus.new(bonus_params)
    flash[:alert] = 'Невозможно добавить расчет премиальных коэффициентов' unless @bonus.save
    redirect_to bonuses_path
  end

  def destroy
    flash[:alert] = 'Невозможно удалить расчет' unless @bonus.destroy
    redirect_to bonuses_path
  end

  private

  def set_bonus
    @bonus = Bonus.find(params[:id])
  end

  def bonus_params
    params.require(:bonus).permit(:date, :sum_prod, :sum_ts)
  end
end
