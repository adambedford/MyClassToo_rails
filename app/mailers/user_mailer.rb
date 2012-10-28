class UserMailer < ActionMailer::Base
  default :from => "notifications@myclasstoo.com"

  def welcome_email(user)
    @user = user
    mail(:to => user.email, :subject => 'Welcome to MyClassToo!')
  end
end
