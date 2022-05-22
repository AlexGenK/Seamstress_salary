class GetProductionsQuery
  def self.call(period, team)
    if team == 'Все'
      scope = Production.where('extract (year from date) = ? AND extract (month from date) = ?', period.year, period.month)
    else
      scope = Production.where('extract (year from date) = ? AND extract (month from date) = ? AND team = ?', period.year, period.month, team)
    end
    scope
  end
end