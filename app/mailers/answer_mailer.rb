class AnswerMailer < ApplicationMailer
  before_action do
    @question = params[:question]
    @user = params[:answer].repliable.user
    @replier = params[:answer].user
  end

  def new_answer_to_question
    I18n.with_locale(I18n.locale) do
      mail to: @user.email, subject: "#{t('.subject')} | AskIt"
    end
  end
end
