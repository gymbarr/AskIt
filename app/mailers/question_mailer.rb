# frozen_string_literal: true

class QuestionMailer < ApplicationMailer
  def notify_subscriber_about_new_question_in_category
    @question = params[:question]
    @user = params[:user]
    @categories = params[:categories]
    @categories_name = params[:categories_name]

    I18n.with_locale(@user.locale) do
      mail to: @user.email, subject: "#{t('.subject', name: @categories_name).truncate(40)} | AskIt"
    end
  end
end
