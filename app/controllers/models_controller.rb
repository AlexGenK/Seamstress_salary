class ModelsController < ApplicationController
  def index
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

  private

  def model_params
      params.require(:model).permit(:number, :name, :sewing)
    end
end
