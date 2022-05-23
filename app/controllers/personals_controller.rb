class PersonalsController < ApplicationController
  before_action :set_bonus

  def index
  end

  private

  def set_bonus
    @bonus = Bonus.find(params[:bonus_id])
  end
end
