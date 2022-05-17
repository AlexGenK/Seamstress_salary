class Production < ApplicationRecord
	validates :date, :user_name, presence: true
end
