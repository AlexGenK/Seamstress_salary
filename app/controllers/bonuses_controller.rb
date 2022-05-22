class BonusesController < ApplicationController
	def index
		@bonuses = Bonus.order(:date)
	end
end
