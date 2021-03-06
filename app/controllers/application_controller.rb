class ApplicationController < ActionController::Base
  include Pagy::Backend
  
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, alert: "У вас нет доступа к этой странице"
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :team])
  end
end
