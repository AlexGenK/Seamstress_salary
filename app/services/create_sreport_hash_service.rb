class CreateSreportHashService

  def self.call(scope, workers_list, models_list, team_list, entity, flash)
    a = {} 
    team_list.each do |item|
      a[item] = []
    end
    table_hash = {}
    workers_list.each do |worker|
      oper_hash = {}
      models_list.each do |model|
        oper_hash[model] = send "get_worker_model_#{entity}", scope, worker, model, flash
      end
      a[User.find_by(name: worker).team] << {worker => oper_hash}
      table_hash[worker] = oper_hash
    end
    return a
  end

  private

  def self.get_worker_model_sum(scope, worker, model, flash)
    worker_model = scope.joins(:works).where('user_name = ? AND works.model_number = ?', worker, model).select('works.sum').first
    if worker_model == nil 
      return 0
    elsif worker_model.sum == nil
      raise "Нулевая строка в отчете по выработке у работника #{worker}"
    else 
      return worker_model.sum.round
    end
  end

  def self.get_worker_model_time(scope, worker, model, flash)
     worker_model = scope.joins(:works).where('user_name = ? AND works.model_number = ?', worker, model).select('works.time').first
     worker_model == nil ? 0 : worker_model.time
  end
end