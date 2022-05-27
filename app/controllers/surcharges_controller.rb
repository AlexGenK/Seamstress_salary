class SurchargesController < ApplicationController
  def index
    @surcharges = Surcharge.all.order(:date, :user_name)
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

  private

  def surcharge_params
    params.require(:surcharge).permit(:user_name, :date, :sum, :comment)
  end
end
