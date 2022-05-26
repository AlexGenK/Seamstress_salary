class GetBonusFactorQuery
  def self.call(date, username)
    begin
      bonus = Bonus.get_by_my(date)
      fc = bonus.personals.find_by(user_name: username).factor
    rescue
      fc = nil
    end
    fc
  end
end