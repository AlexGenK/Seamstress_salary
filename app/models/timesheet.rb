class Timesheet < ApplicationRecord
	validates :date, presence: true

	has_many :visits, dependent: :destroy
end
