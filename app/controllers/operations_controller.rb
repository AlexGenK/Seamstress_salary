class OperationsController < ApplicationController
  before_action :set_model

  def index
    @operations = @model.operations.all.order(:number)
  end

  private

  def set_model
    @model = Model.find(params[:model_id])
  end
end
