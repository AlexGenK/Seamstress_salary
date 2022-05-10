class FactorsController < ApplicationController
   before_action :set_factor, only: [:edit, :update, :destroy]

   def index
    @factors = Factor.order(:min)
   end

   def new
    @factor = Factor.new
   end

   def create
    value_multiplication    
    @factor = Factor.new(factor_params)
      if @factor.save
        redirect_to factors_path
      else
        flash[:alert] = 'Невозможно добавить коэффициент'
        render :new
      end
   end

   private

   def value_multiplication
    params['factor']['value'] = (params['factor']['value'].to_f * 100).to_s
   end

   def factor_params
    params.require(:factor).permit(:min, :max, :value)
   end

   def set_factor
    @factor = Factor.find(params[:id])
   end
end
