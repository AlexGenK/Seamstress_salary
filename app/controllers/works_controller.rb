class WorksController < ApplicationController
  before_action :set_production
  before_action :set_work, only: [:destroy]
  after_action :recalculate_production_sum, only: [:create, :destroy]
  after_action :recalculate_production_time, only: [:create, :destroy]

  def index
    @work = @production.works.new
    @works = @production.works.all
  end

  def create
    @work = @production.works.new(work_params)
    flash[:alert] = 'Невозможно добавить модель' unless @work.save
    redirect_to production_works_path(@production)
  end

  def destroy
    flash[:alert] = 'Невозможно удалить сведения' unless @work.destroy
    redirect_to production_works_path(@production)
  end

  private

  def work_params
    params.require(:work).permit(:model_id, :sum, :time)
  end

  def set_production
    @production = Production.find(params[:production_id])
  end

  def set_work
    @work = Work.find(params[:id])
  end

  def recalculate_production_sum
    @production.calculate_sum
  end

  def recalculate_production_time
    @production.calculate_time
  end
end
