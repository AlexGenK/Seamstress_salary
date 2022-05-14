class Model < ApplicationRecord
  validates :sewing, :name, :number, presence: true

  has_many :operations, dependent: :destroy

  def calculate_cost
    self.update(cost: self.operations.sum(:cost))
  end
end
