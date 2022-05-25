class ProductionsController < ApplicationController
  before_action :set_production, only: [:destroy, :show]
  load_and_authorize_resource

  def index
    @production = Production.new(date: Date.today)
    @productions = Production.order(date: :desc, user_name: :asc)
    @user_names = User.get_worker_names
  end

  def create
    @production = Production.new(production_params)
    @production.team = User.find_by(name: @production.user_name).team
    flash[:alert] = 'Невозможно добавить отчет по выработке' unless @production.save
    redirect_to productions_path
  end

  def destroy
    flash[:alert] = 'Невозможно удалить отчет по выработке' unless @production.destroy
    redirect_to productions_path
  end

  def show
  end

  private

  def production_params
    params.require(:production).permit(:user_name, :date, :sum, :time)
  end

  def set_production
    @production = Production.find(params[:id])
  end
end
