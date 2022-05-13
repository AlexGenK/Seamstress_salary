class Model < ApplicationRecord
  validates :sewing, :name, :number, presence: true

  has_many :operations, dependent: :destroy
end
