# frozen_string_literal: true

class Passwords::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
    super
  end

  # POST /resource/sign_in
  def create
    super do |resource|
      if resource && resource.verified? # Assuming you have a method named 'verified?' in your User model
        flash[:notice] = "Signed in successfully."
      elsif resource && !resource.verified?
        flash[:alert] = "Your account is not verified yet. Please check your email for verification instructions."
        sign_out resource
      end
    end
    end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
