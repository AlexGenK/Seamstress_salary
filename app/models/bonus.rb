class Bonus < ApplicationRecord
  has_many :personals, dependent: :destroy

  def calculate_sum
    self.update(sum_prod: self.personals.sum(:report_time))
    self.update(sum_ts: self.personals.sum(:timesheet_time))
  end
end
