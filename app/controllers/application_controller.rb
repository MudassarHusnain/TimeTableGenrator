class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:email, :password,:password_confirmation,:username,:roles)}

    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:email, :password, :password_confirmation,:username,:roles)}
  end

  rescue_from CanCan::AccessDenied, with: :access_denied

  private

  def access_denied
    flash[:alert] = "You are not authorized to access this page."
    redirect_to request.referrer
  end
end
