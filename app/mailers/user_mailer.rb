class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def deleted_user_notification(user)
    @user = user
    mail(to: @user.email, subject: "..Any stay out!")
  end
end
