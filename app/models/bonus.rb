class Bonus < ApplicationRecord
	has_many :personals, dependent: :destroy
end
