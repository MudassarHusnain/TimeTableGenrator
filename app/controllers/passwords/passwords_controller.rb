# frozen_string_literal: true

class Passwords::PasswordsController < Devise::PasswordsController
  # GET /resource/password/new
  def new
    @user = User.new

  end

  # POST /resource/password
  def create
    @user = User.find_by(email: params[:user][:email])
    raw, enc = Devise.token_generator.generate(User, :reset_password_token)
    @user.reset_password_token = enc
    @user.reset_password_sent_at = Time.now.utc
    if @user
      if @user.save
        UserMailer.forget_password_email(@user).deliver_now
        flash[:notice] = "Password reset instructions have been sent to your email."
        redirect_to root_path
      end
    else
      flash.now[:notice] = "Email address not found."
      render :new
    end
  end

  # GET /resource/password/edit?reset_password_token=abcdef
  def edit
    @user = User.find_by(reset_password_token: params[:reset_password_token])
    if @user
      render :edit
    else
      flash.now[:notice] = "Invalid reset password token."
      render :new
    end
  end

  # PUT /resource/password
  def update
    @user = User.find_by(reset_password_token: params[:user][:reset_password_token])
    if @user
      if @user.reset_password(params[:user][:password], params[:user][:password_confirmation])
        flash[:notice] = "Your password has been changed successfully."
        redirect_to root_path
      else
        render :edit
      end
    else
      flash.now[:notice] = "Invalid reset password token."
      render :new
    end
  end
  # protected

  # def after_resetting_password_path_for(resource)
  #   super(resource)
  # end

  # The path used after sending reset password instructions
  # def after_sending_reset_password_instructions_path_for(resource_name)
  #   super(resource_name)
  # end
end
