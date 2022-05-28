class WorksController < ApplicationController
  include Verifiable

  before_action :set_production
  before_action :set_work, only: [:destroy]
  before_action :detect_invalid_user
  
  after_action :recalculate_production_sum, only: [:create, :destroy]
  after_action :recalculate_production_time, only: [:create, :destroy]
  load_and_authorize_resource

  def index
    @work = @production.works.new
    @works = @production.works.all.order(:model_number)
    @page = session[:page]
  end

  def create
    @work = @production.works.new(work_params)
    @model = Model.find(work_params[:model_id])
    @work.model_nname = @model.name
    @work.model_number = @model.number
    if @production.works.find_by(model_nname: @work.model_nname) != nil
      @work.destroy
      redirect_to production_works_path(@production), alert: 'Невозможно добавить уже имеющуюся модель!'
      return
    end
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
