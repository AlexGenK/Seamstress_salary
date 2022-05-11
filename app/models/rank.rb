class Rank < ApplicationRecord
	validates :type, :category, :cost, presence: true
	validates :category, :cost, numericality: {greater_than: 0}
end
