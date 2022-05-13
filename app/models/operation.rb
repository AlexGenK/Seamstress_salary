class Operation < ApplicationRecord
  validates :number, :name, :category, :time, presence: true

  belongs_to :model
end
