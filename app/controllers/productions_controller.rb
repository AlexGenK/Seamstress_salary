class ProductionsController < ApplicationController
  def index
    @production = Production.new(date: Date.today)
    @productions = Production.order(date: :desc, user_name: :asc)
    @user_names = User.where({worker_role: true}).order(:name).pluck(:name)
  end

  def create
    @production = Production.new(production_params)
    flash[:alert] = 'Невозможно добавить отчет по выработке' unless @production.save
    redirect_to productions_path
  end

  private

  def production_params
    params.require(:production).permit(:user_name, :date, :sum, :time)
  end
end
