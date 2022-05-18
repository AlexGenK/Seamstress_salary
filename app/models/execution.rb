class Execution < ApplicationRecord
  validates :quantity, :sum, :time, presence: true

  belongs_to :works
  belongs_to :operations
end
