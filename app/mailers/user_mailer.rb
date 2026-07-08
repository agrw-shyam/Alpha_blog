class UserMailer < ApplicationMailer
  default from: 'notifications@alphablog.com'

def welcome_email(user)
  @user = user
  mail(to: @user.email, subject: 'Welcome to Alpha Blog!')
end

end
