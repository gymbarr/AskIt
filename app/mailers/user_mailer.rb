class UserMailer < ApplicationMailer
  def notify_subscriber
    @user = params[:user]
    @category = params[:category]
    @question = params[:question]

    mail to: @user.email, subject: "New question in the #{@category.name} category! | AskIt"
  end

  def notify_new_reply
    @question = params[:question]
    reply = params[:reply]
    @user = reply.repliable.user
    @replier = reply.user

    I18n.with_locale(I18n.locale) do
      mail to: @user.email, subject: "#{t('.subject')} | AskIt"
    end
  end
end
