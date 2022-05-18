class Work < ApplicationRecord
  belongs_to :production
  belongs_to :model

  has_many :executions, dependent: :destroy

  def calculate_sum
    self.update(sum: self.executions.sum(:sum))
    self.production.calculate_sum
  end

  def calculate_time
    self.update(time: self.executions.sum(:time))
    self.production.calculate_time
  end
end
