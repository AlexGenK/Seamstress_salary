class CreateSreportHashService
  def self.call(scope, workers_list, models_list)
    table_hash = {}
    workers_list.each do |worker|
      oper_hash = {}
      models_list.each do |model|
        oper_hash[model] = get_worker_model_sum(scope, worker, model)
      end
      table_hash[worker] = oper_hash
    end
    return table_hash
  end

  private

  def self.get_worker_model_sum(scope, worker, model)
     worker_model = scope.joins(:works).where('user_name = ? AND works.model_number = ?', worker, model).select('works.sum').first
     worker_model == nil ? 0 : worker_model.sum.round
  end
end