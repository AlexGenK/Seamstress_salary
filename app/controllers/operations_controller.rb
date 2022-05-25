class OperationsController < ApplicationController
  before_action :set_model
  before_action :set_operation, only: [:edit, :update, :destroy]
  after_action :recalculate_model_cost, only: [:create, :update, :destroy, :filling]
  load_and_authorize_resource

  def index
    @operations = @model.operations.order(Arel.sql("(substring(number, '^[0-9]+'))::int, substring(concat(number, '!'), '[^0-9_].*$')"))
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

  def edit
  end

  def update
    if @operation.update(operation_params)
      unless @operation.calc_cost!
        flash[:alert] = 'Невозможно рассчитать стоимость операции'
        render :edit
      end
      @operation.save
      redirect_to model_operations_path(@model, anchor: "operation-#{@operation.id - 5}")
    else
      flash[:alert] = 'Невозможно отредактировать операцию'
      render :edit
    end
  end

  def destroy
    flash[:alert] = 'Невозможно удалить операцию' unless @operation.destroy
    redirect_to model_operations_path(@model)
  end

  def filling
    begin
      @imported_records = ReadCsvFileService.call(params[:datafile], [:number, :name, :kind, :category, :time])
      @records_to_operations = ModifyHashService.to_operations(@imported_records)
      @counter = MassCreateOperationsQuery.call(@model, @records_to_operations)
    rescue
      flash[:alert] = 'Не удалось загрузить операции'
    else
      flash[:notice] = 'Операции успешно загружены'
    end
    redirect_to model_operations_path(@model)
  end

  private

  def set_model
    @model = Model.find(params[:model_id])
  end

  def set_operation
    @operation = Operation.find(params[:id])
  end

  def recalculate_model_cost
    @model.calculate_cost
  end

  def operation_params
    params.require(:operation).permit(:number, :name, :kind, 
                                      :category, :time, :cost)
  end
end
