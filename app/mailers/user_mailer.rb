class UserMailer < ApplicationMailer
  default from: "mudassarhusnain64@gmail.com"
  layout "mailer"

  def welcome_email(user)
    debugger
    @user = user
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end
end