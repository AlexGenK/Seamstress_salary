class SurchargesController < ApplicationController
  before_action :set_surcharge, only: [:edit, :update, :destroy]

  def index
    @surcharges = Surcharge.all.order('date DESC, user_name')
  end

  def new
    @surcharge = Surcharge.new(date: Date.today)
    @user_names = User.get_worker_names
  end

  def create
    @surcharge = Surcharge.new(surcharge_params)
    if @surcharge.save
      redirect_to surcharges_path
    else
      flash[:alert] = 'Невозможно добавить начисление'
      render :new
    end
  end

  def edit
    @user_names = User.get_worker_names
  end

  def update
    if @surcharge.update(surcharge_params)
      redirect_to surcharges_path
    else
      flash[:alert] = 'Невозможно отредактировать начисление'
      render :edit
    end
  end

  def destroy
    flash[:alert] = 'Невозможно удалить начисление' unless @surcharge.destroy
    redirect_to surcharges_path
  end

  private

  def surcharge_params
    params.require(:surcharge).permit(:user_name, :date, :sum, :comment)
  end

  def set_surcharge
    @surcharge = Surcharge.find(params[:id])
  end  
end
