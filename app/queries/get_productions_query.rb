class GetProductionsQuery
  def self.call(period)
    Production.where('extract (year from date) = ? AND extract (month from date) = ?', period.year, period.month)
  end
end