class Model < ApplicationRecord
  validates :sewing, :name, :number, presence: true
end
