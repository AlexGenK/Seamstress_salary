class Timesheet < ApplicationRecord
  validates :date, presence: true

  has_many :visits, dependent: :destroy

  def calculate_sum
    self.update(sum: self.visits.sum(:time))
  end

  def self.get_by_my(date)
    self.where('extract (year from date) = ? AND extract (month from date) = ?', date.year, date.month).first
  end
end
