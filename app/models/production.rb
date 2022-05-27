class Production < ApplicationRecord
  validates :date, :user_name, presence: true

  has_many :works, dependent: :destroy

  def calculate_sum
    self.update(sum: self.works.sum(:sum).round)
  end

  def calculate_time
    self.update(time: self.works.sum(:time))
  end

  def self.get_by_my(date, username)
    self.where('extract (year from date) = ? AND extract (month from date) = ? AND user_name = ?', date.year, date.month, username).first
  end
end
