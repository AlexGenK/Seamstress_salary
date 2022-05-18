class Execution < ApplicationRecord
  validates :quantity, :sum, :time, presence: true

  belongs_to :work
  belongs_to :operation
end
