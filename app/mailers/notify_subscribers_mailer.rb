class NotifySubscribersMailer < ApplicationMailer
  def notify_subscriber
    @user = params[:user]
    @category = params[:category]
    @question = params[:question]

    mail to: @user.email, subject: "New question in the #{@category.name} category! | AskIt"
  end
end
