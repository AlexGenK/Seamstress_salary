class Production < ApplicationRecord
	validates :date, :user_name, presence: true

	has_many :works, dependent: :destroy
end
