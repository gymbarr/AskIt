# frozen_string_literal: true

class CommentMailer < ApplicationMailer
  def notify_user_about_new_comment
    @question = params[:question]
    @user = params[:user]
    @replier = params[:replier]

    I18n.with_locale(@user.locale) do
      mail to: @user.email, subject: "#{t('.subject')} | AskIt"
    end
  end
end
