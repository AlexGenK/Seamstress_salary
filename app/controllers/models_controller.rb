class ModelsController < ApplicationController
  before_action :set_model, only: [:edit, :update, :destroy, :recalculate]
  load_and_authorize_resource

  def index
    flash[:alert] = nil
    @models = Model.order(:number)
  end

  def new
    @model = Model.new
  end

  def create
    @model = Model.new(model_params)
    if @model.save
      redirect_to models_path
    else
      flash[:alert] = 'Невозможно добавить модель'
      render :new
    end
  end

  def destroy
    flash[:alert] = 'Невозможно удалить модель' unless @model.destroy
    redirect_to models_path
  end

  def edit
  end

  def update
    if @model.update(model_params)
      redirect_to models_path
    else
      flash[:alert] = 'Невозможно отредактировать модель'
      render :edit
    end
  end

  def recalculate
    @model.operations.each do |oper| 
      oper.calc_cost!
      oper.save
    end
    @model.calculate_cost
    @model.save
    flash[:notice] = 'Стоимость модели перерасчитана'
    redirect_to model_operations_path(@model)
  end

  private

  def model_params
    params.require(:model).permit(:number, :name, :sewing)
  end

  def set_model
    @model = Model.find(params[:id])
  end
end
