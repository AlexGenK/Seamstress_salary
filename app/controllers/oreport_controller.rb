class OreportController < ApplicationController
  authorize_resource :class => false
  
  def edit
  end

  def new
    report_date = Date.strptime(params[:date], '%Y-%m')
    current_productions = GetProductionsQuery.call(report_date, 'Все')
    workers_list = GetProductionsListsQuery.workers(current_productions)
    models_list = GetProductionsListsQuery.models(current_productions)
    model_hash = CreateOreportHashService.call(current_productions)
    table_xl = CreateOreportTableService.call(model_hash, models_list, report_date)
    send_data table_xl.stream.string, filename: "operation.xlsx", disposition: 'attachment'
  end

end
