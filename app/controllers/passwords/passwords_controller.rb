# frozen_string_literal: true

class Passwords::PasswordsController < Devise::PasswordsController
  # GET /resource/password/new
  # def new
  #   super
  #   debugger
  # end

  # POST /resource/password
  # def create
  #   super
  #   debugger
  #   if @user
  #     UserMailer.welcome_email(@user).deliver_now
  #     flash[:success] = "Password reset instructions have been sent to your email."
  #     redirect_to root_path
  #   else
  #     flash.now[:error] = "Email address not found."
  #     render :new
  #   end
  # end

  # GET /resource/password/edit?reset_password_token=abcdef
  # def edit
  #
  #   debugger
  # end

  # PUT /resource/password
  # def update
  #
  # end

  # protected

  # def after_resetting_password_path_for(resource)
  #   super(resource)
  # end

  # The path used after sending reset password instructions
  # def after_sending_reset_password_instructions_path_for(resource_name)
  #   super(resource_name)
  # end
end
