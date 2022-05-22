class SreportController < ApplicationController
  def edit
  end

  def new
    current_productions = GetProductionsQuery.call(Date.strptime(params[:date], '%Y-%m'), params[:team])
    workers_list = GetProductionsListsQuery.workers(current_productions)
    models_list = GetProductionsListsQuery.models(current_productions)
    teams_list = GetProductionsListsQuery.teams(current_productions)
    sum_hash = CreateSreportHashService.call(current_productions, workers_list, models_list, teams_list, 'sum')
    time_hash = CreateSreportHashService.call(current_productions, workers_list, models_list, teams_list, 'time')
    table_xl = CreateSreportTableService.call(sum_hash, time_hash, models_list)
    send_data table_xl.stream.string, filename: "salaryreport.xlsx", disposition: 'attachment'
  end
end
