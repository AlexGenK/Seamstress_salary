class Model < ApplicationRecord
  validates :sewing, :name, :number, presence: true
  validates :number, :name, uniqueness: true

  has_many :operations, dependent: :destroy

  scope :actual, -> { where(visibility: true) }

  def calculate_cost
    self.update(cost: self.operations.sum(:cost))
  end
end
