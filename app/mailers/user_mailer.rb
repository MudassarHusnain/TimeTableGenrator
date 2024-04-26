class UserMailer < ApplicationMailer
  default from: "mudassarhusnain64@gmail.com"
  layout "mailer"

  def forget_password_email(user)
    @user = user
    mail(to: @user.email, subject: 'You can reset your password')
  end

  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end
end