class Production < ApplicationRecord
  validates :date, :user_name, presence: true

  has_many :works, dependent: :destroy

  def calculate_sum
    self.update(sum: self.works.sum(:sum))
  end

  def calculate_time
    self.update(time: self.works.sum(:time))
  end
end
