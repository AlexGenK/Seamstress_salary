class SreportController < ApplicationController
  def edit
  end

  def new
    current_productions = GetProductionsQuery.call(Date.strptime(params[:date], '%Y-%m'))
    workers_list = GetProductionsListsQuery.workers(current_productions)
    models_list = GetProductionsListsQuery.models(current_productions)
    table_hash = CreateSreportHashService.call(current_productions, workers_list, models_list)
    p table_hash
  end
end
