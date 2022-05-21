class GetProductionsListsQuery

  def self.workers(scope)
    scope.order(:user_name).pluck(:user_name)
  end

  def self.models(scope)
    scope.joins(:works).order(:model_number).pluck(:model_number).uniq
  end

  def self.teams(scope)
    a = []
    scope.each do |production|
      team = User.find_by(name: production.user_name).team
      a << team unless a.include?(team)
    end
    a.sort
  end
end