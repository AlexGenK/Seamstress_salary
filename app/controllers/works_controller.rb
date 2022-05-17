class WorksController < ApplicationController
  before_action :set_production

  def index
    @works = @production.works.all
  end

  private

  def set_production
    @production = Production.find(params[:production_id])
  end
end
