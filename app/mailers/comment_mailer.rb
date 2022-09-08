class CommentMailer < ApplicationMailer
  def notify_user_about_new_comment
    @question = params[:question]
    @user = params[:user]
    @replier = params[:replier]

    I18n.with_locale(I18n.locale) do
      mail to: @user.email, subject: "#{t('.subject')} | AskIt"
    end
  end
end
