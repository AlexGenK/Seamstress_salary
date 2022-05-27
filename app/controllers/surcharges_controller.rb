class SurchargesController < ApplicationController
  def index
    @surcharges = Surcharge.all.order(:date)
  end
end
