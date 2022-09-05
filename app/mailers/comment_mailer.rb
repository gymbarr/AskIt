class NewCommentMailer < ApplicationMailer
  before_action do
    @question = params[:question]
    @user = params[:comment].repliable.user
    @replier = params[:comment].user
  end

  def new_comment_to_answer
    I18n.with_locale(I18n.locale) do
      mail to: @user.email, subject: "#{t('.subject')} | AskIt"
    end
  end

  def new_comment_to_comment
    I18n.with_locale(I18n.locale) do
      mail to: @user.email, subject: "#{t('.subject')} | AskIt"
    end
  end
end
