class SreportController < ApplicationController
  authorize_resource :class => false
  
  def edit
  end

  def new
    report_date = Date.strptime(params[:date], '%Y-%m')
    current_productions = GetProductionsQuery.call(report_date, params[:team])
    workers_list = GetProductionsListsQuery.workers(current_productions)
    models_list = GetProductionsListsQuery.models(current_productions)
    teams_list = GetProductionsListsQuery.teams(current_productions)
    begin
      sum_hash = CreateSreportHashService.call(current_productions, workers_list, models_list, teams_list, 'sum', flash)
    rescue => e
      flash[:alert] = e.message
      redirect_to edit_sreport_path
      return
    end
    time_hash = CreateSreportHashService.call(current_productions, workers_list, models_list, teams_list, 'time', flash)
    table_xl = CreateSreportTableService.call(sum_hash, time_hash, models_list, report_date)
    send_data table_xl.stream.string, filename: "salaryreport.xlsx", disposition: 'attachment'
  end
end
