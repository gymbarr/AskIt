class AnswerMailer < ApplicationMailer
  def new_answer_to_question
    @question = Question.find(params[:question_id])
    answer = Answer.find(params[:answer_id])
    @user = answer.repliable.user
    @replier = answer.user

    I18n.with_locale(I18n.locale) do
      mail to: @user.email, subject: "#{t('.subject')} | AskIt"
    end
  end
end
