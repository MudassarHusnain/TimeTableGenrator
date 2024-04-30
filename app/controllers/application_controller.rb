class ApplicationController < ActionController::Base


  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:email, :password,:password_confirmation,:username,:roles,:department_id)}

    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:email, :password, :password_confirmation,:username,:roles,:department_id)}
  end

  rescue_from CanCan::AccessDenied, with: :access_denied

  private

  def access_denied
    @department = Department.find_by(id: current_user.department_id)
    redirect_to department_dep_time_table_path(@department)
  end
end
