class ProductionsController < ApplicationController
  include Verifiable

  before_action :set_production, only: [:destroy, :show]
  before_action :detect_invalid_user, only: [:destroy, :show]

  load_and_authorize_resource

  def index
    @production = Production.new(date: Date.today)
    if current_user.admin_role?
      @pagy, @productions = pagy(Production.order(date: :desc, user_name: :asc))
      @user_names = User.get_worker_names
    else
      @pagy, @productions = pagy(Production.where(user_name: current_user.name).order(date: :desc, user_name: :asc))
      @user_names = [current_user.name]
    end
    session[:page] = @pagy.page
  end

  def create
    @production = Production.new(production_params)
    if Production.get_by_my(@production.date, @production.user_name) != nil
      redirect_to productions_path(page: session[:page]), alert: "Отчет пользователя #{@production.user_name} за этот месяц уже существует!"
      return
    end
    @production.team = User.find_by(name: @production.user_name).team
    flash[:alert] = 'Невозможно добавить отчет по выработке' unless @production.save
    redirect_to productions_path(page: session[:page])
  end

  def destroy
    flash[:alert] = 'Невозможно удалить отчет по выработке' unless @production.destroy
    redirect_to productions_path(page: session[:page])
  end

  def show
    @all_sum = @production.sum.to_i
    @bf = GetBonusFactorQuery.call(@production.date, @production.user_name)
    @baf_sum = (@all_sum * @production.works.size * AsortBonus.first.factor).round
    @all_sum += @baf_sum
    @sc_sum = GetSurchargeQuery.call(@production.date, @production.user_name)
    @all_sum += @sc_sum
    if @bf == nil
      @bf_sum = 'не расчитано'
    else
      @bf_sum = (@production.sum * @bf).round
      @all_sum += @bf_sum
    end
     
  end

  private

  def production_params
    params.require(:production).permit(:user_name, :date, :sum, :time)
  end

  def set_production
    @production = Production.find(params[:id])
  end
end
