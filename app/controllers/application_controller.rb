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

  # Método auxiliar para manejar notificaciones flash con Turbo Stream
  def flash_turbo_stream_with_notice(message, actions = [])
    flash.now[:notice] = message
    actions << turbo_stream.update("flash-messages", partial: "shared/flash_content")
    render turbo_stream: actions
  end

  # Método auxiliar para manejar alertas flash con Turbo Stream
  def flash_turbo_stream_with_alert(message, actions = [])
    flash.now[:alert] = message
    actions << turbo_stream.update("flash-messages", partial: "shared/flash_content")
    render turbo_stream: actions
  end
end
