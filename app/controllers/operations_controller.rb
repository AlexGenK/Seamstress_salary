class OperationsController < ApplicationController
  before_action :set_model

  def index
    flash[:alert] = nil
    @operations = @model.operations.order(:number)
  end

  def new
    @operation = @model.operations.new
  end

  def create
    @operation = @model.operations.new(operation_params)
    unless @operation.calc_cost!
      flash[:alert] = 'Невозможно рассчитать стоимость операции'
      render :new
    end
    if @operation.save
      redirect_to model_operations_path(@model)
    else
      flash[:alert] = 'Невозможно добавить операцию'
      render :new
    end
  end

  private

  def set_model
    @model = Model.find(params[:model_id])
  end

  def operation_params
    params.require(:operation).permit(:number, :name, :kind, 
                                      :category, :time, :cost)
  end
end
