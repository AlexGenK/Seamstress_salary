class Surcharge < ApplicationRecord
	validates :date, :user_name, :sum, presence: true
end
