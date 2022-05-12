class ModelsController < ApplicationController
	def index
		@models = Model.order(:number)
	end
end
