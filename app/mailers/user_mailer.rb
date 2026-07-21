class UserMailer < ApplicationMailer
  default from: 'notifications@alphablog.com'

  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to Alpha Blog!')
  end

  def article_deleted(user, article_title)
    @user = user
    @article_title = article_title
    mail(to: @user.email, subject: 'Your article has been deleted')
  end
end
