class FactorsController < ApplicationController
  before_action :set_factor, only: [:edit, :update, :destroy]
  load_and_authorize_resource

  def index
    @factors = Factor.order(:min)
  end

  def new
    @factor = Factor.new
  end

  def create   
    @factor = Factor.new(factor_params)
    if @factor.save
      redirect_to factors_path
    else
      flash[:alert] = 'Невозможно добавить коэффициент'
      render :new
    end
  end

  def destroy
    flash[:alert] = 'Невозможно удалить коэффициент' unless @factor.destroy
    redirect_to factors_path
  end

  def edit
  end

  def update
    if @factor.update(factor_params)
      redirect_to factors_path
    else
      flash[:alert] = 'Невозможно отредактировать коэффициент'
      render :edit
    end
  end

  private

  def factor_params
    params.require(:factor).permit(:min, :max, :value)
  end

  def set_factor
    @factor = Factor.find(params[:id])
  end
end
