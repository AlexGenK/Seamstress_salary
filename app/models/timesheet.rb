class Timesheet < ApplicationRecord
  validates :date, presence: true

  has_many :visits, dependent: :destroy

  def calculate_sum
    self.update(sum: self.visits.sum(:time))
  end
end
