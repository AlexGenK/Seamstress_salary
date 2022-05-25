class RanksController < ApplicationController
  before_action :set_rank, only: [:edit, :update, :destroy]
  load_and_authorize_resource

  def index
    @ranks=Rank.order(:sewing, :category)
  end

  def new
    @rank = Rank.new
  end

  def create
    @rank = Rank.new(rank_params)
    if @rank.save
      redirect_to ranks_path
    else
      flash[:alert] = 'Невозможно добавить разряд'
      render :new
    end
  end

  def destroy
    flash[:alert] = 'Невозможно удалить разряд' unless @rank.destroy
    redirect_to ranks_path
  end

  def edit
  end

  def update
    if @rank.update(rank_params)
      redirect_to ranks_path
    else
      flash[:alert] = 'Невозможно отредактировать коэффициент'
      render :edit
    end
  end
  private

  def rank_params
    params.require(:rank).permit(:sewing, :category, :cost)
  end

  def set_rank
    @rank = Rank.find(params[:id])
  end
end
