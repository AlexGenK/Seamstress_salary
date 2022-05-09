class Factor < ApplicationRecord
	validates: :min, :max, :value, presence: true
end
