class NotificateSubscribersMailer < ApplicationMailer
  def notificate_subscriber
    @user = params[:user]
    category = params[:category]

    mail to: @user.email, subject: "New questions on #{category.name} category! | AskIt"
  end
end