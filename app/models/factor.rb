class Factor < ApplicationRecord
  validates :min, :max, :value, presence: true

  def self.get_by_percent(percent)
    factor = Factor.where('min <= ? AND max >= ?', percent, percent)[0]
    factor.value
  end
end
