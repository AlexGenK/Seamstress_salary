class Visit < ApplicationRecord
  validates :time, :user_name, presence: true

  belongs_to :timesheet
end
