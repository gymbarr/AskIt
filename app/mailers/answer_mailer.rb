class AnswerMailer < ApplicationMailer
  def new_answer_notify
    @question = params[:question]
    @user = params[:user]
    @replier = params[:replier]

    I18n.with_locale(I18n.locale) do
      mail to: @user.email, subject: "#{t('.subject')} | AskIt"
    end
  end
end
