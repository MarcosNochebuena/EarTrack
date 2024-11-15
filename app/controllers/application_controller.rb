class ApplicationController < ActionController::Base
  include Pagy::Backend
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  before_action :ensure_producer_assigned, unless: :producer_controller?
  
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :phone_number])
  end

  def ensure_producer_assigned
    if current_user && !current_user.producer
      flash[:alert] = "Debes configurar un productor antes de continuar."
      redirect_to producers_path
    end
  end

  def producer_controller?
    controller_name == "producers"
  end
end