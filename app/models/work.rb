class Work < ApplicationRecord
  belongs_to :production
  belongs_to :model

  has_many :executions, dependent: :destroy
end
