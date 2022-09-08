class QuestionMailer < ApplicationMailer
  def new_question_notify
    @question = params[:question]
    @user = params[:user]
    @categories = params[:categories]
    @categories_name = params[:categories_name]

    I18n.with_locale(I18n.locale) do
      mail to: @user.email, subject: "#{t('.subject', name: @categories_name)} | AskIt"
    end
  end
end
