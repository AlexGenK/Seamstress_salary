class GetSurchargeQuery
  def self.call(date, username)
    begin
      surcharges = Surcharge.get_by_my(date)
      sc_sum = surcharges.where(user_name: username).sum(:sum)
    rescue
      sc_sum = 0
    end
    sc_sum
  end
end