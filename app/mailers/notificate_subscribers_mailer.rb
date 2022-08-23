class NotifySubscribersMailer < ApplicationMailer
  def notify_subscriber
    @user = params[:user]
    @category = params[:category]

    mail to: @user.email, subject: "New questions on #{@category.name} category! | AskIt"
  end
end
