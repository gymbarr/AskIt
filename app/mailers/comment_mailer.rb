class CommentMailer < ApplicationMailer
  before_action do
    @question = Question.find(params[:question_id])
    comment = Comment.find(params[:comment_id])
    @user = comment.repliable.user
    @replier = comment.user
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
