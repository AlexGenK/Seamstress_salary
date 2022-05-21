class CreateSreportHashService
  def self.call(scope, workers_list, models_list, team_list)
    a = {} 
    team_list.each do |item|
      a[item] = []
    end
    table_hash = {}
    workers_list.each do |worker|
      oper_hash = {}
      models_list.each do |model|
        oper_hash[model] = get_worker_model_sum(scope, worker, model)
      end
      a[User.find_by(name: worker).team] << {worker => oper_hash}
      table_hash[worker] = oper_hash
    end
    return a
  end

  private

  def self.get_worker_model_sum(scope, worker, model)
     worker_model = scope.joins(:works).where('user_name = ? AND works.model_number = ?', worker, model).select('works.sum').first
     worker_model == nil ? 0 : worker_model.sum.round
  end
end