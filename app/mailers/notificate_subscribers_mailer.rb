class NotificateSubscribersMailer < ApplicationMailer
  def notificate_email
    @users = params[:users]
    @category = params[:category]

    @users.each do |user|
      mail to: user.email, subject: "New questions on #{@category.name} category! | AskIt"
    end
  end
end