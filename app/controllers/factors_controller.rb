class FactorsController < ApplicationController
	 before_action :set_factor, only: [:edit, :update, :destroy]

	 def index
	 	@factors = Factor.order(:min)
	 end

	 private

	 def set_factor
	 	@factor = Factor.find(params[:id])
	 end
end
