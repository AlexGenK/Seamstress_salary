class OperationsController < ApplicationController
  before_action :set_model

  def index
    @operations = @model.operations.all.order(:number)
  end

  def new
    @operation = @model.operations.new
  end

  def create
    @operation = @model.operations.new(operation_params)
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
