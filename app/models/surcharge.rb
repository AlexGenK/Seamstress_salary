class Surcharge < ApplicationRecord
	validates :date, :user_name, :sum, presence: true

  def self.get_by_my(date)
    Surcharge.where('extract (year from date) = ? AND extract (month from date) = ?', date.year, date.month)
  end
end
