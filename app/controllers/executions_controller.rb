class ExecutionsController < ApplicationController
  before_action :set_production
  before_action :set_work
  before_action :set_execution, only: [:destroy]

  def index
    @executions = @work.executions.all
    @execution = @work.executions.new
    @oper_list = @work.model.operations.all.order(Arel.sql("(substring(number, '^[0-9]+'))::int, substring(concat(number, '!'), '[^0-9_].*$')")).collect {|o| ["#{o.number} - #{o.name.truncate(50)}", o.id]}
  end

  def create
    @execution = @work.executions.new(execution_params)
    @execution.sum = @execution.operation.cost * @execution.quantity
    @execution.time = @execution.operation.time * @execution.quantity
    flash[:alert] = 'Невозможно добавить выполнение' unless @execution.save
    redirect_to production_work_executions_path(@production, @work)
  end

  def destroy
    flash[:alert] = 'Невозможно удалить выполнение' unless @execution.destroy
    redirect_to production_work_executions_path(@production, @work)
  end

  private

  def set_production
    @production = Production.find(params[:production_id])
  end

  def set_work
    @work = Work.find(params[:work_id])
  end

  def set_execution
    @execution = Execution.find(params[:id])
  end

  def execution_params
    params.require(:execution).permit(:operation_id, :quantity, :sum, :time)
  end
end
