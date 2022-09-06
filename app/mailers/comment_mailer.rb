class CommentMailer < ApplicationMailer
  def new_comment_notify
    @question = Question.find(params[:question_id])
    comment = Comment.find(params[:comment_id])
    @user = comment.repliable.user
    @replier = comment.user

    I18n.with_locale(I18n.locale) do
      mail to: @user.email, subject: "#{t('.subject')} | AskIt"
    end
  end
end
