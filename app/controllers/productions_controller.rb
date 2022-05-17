class ProductionsController < ApplicationController
  before_action :set_production, only: [:destroy]

  def index
    @production = Production.new(date: Date.today)
    @productions = Production.order(date: :desc, user_name: :asc)
    @user_names = User.get_worker_names
  end

  def create
    @production = Production.new(production_params)
    flash[:alert] = 'Невозможно добавить отчет по выработке' unless @production.save
    redirect_to productions_path
  end

  def destroy
    flash[:alert] = 'Невозможно удалить отчет по выработке' unless @production.destroy
    redirect_to productions_path
  end

  private

  def production_params
    params.require(:production).permit(:user_name, :date, :sum, :time)
  end

  def set_production
    @production = Production.find(params[:id])
  end
end
