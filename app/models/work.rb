class Work < ApplicationRecord
  belongs_to :production
  belongs_to :model

  has_many :operations, dependent: :destroy
end
