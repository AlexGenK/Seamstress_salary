class Timesheet < ApplicationRecord
	validates :date, presence: true
end
