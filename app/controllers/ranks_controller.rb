class RanksController < ApplicationController
  def index
    @ranks=Rank.order(:type, :category)
  end
end
