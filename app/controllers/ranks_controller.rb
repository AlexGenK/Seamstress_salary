class RanksController < ApplicationController
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

  private

  def rank_params
    params.require(:rank).permit(:sewing, :category, :cost)
  end
end
