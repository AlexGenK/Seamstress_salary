class GetProductionsListsQuery

  def self.workers(scope)
    scope.order(:user_name).pluck(:user_name)
  end

  def self.models(scope)
    scope.joins(:works).order(:model_number).pluck(:model_number).uniq
  end
end