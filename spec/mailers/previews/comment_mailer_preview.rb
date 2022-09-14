# Preview all emails at http://localhost:3000/rails/mailers/comment_mailer
class CommentMailerPreview < ActionMailer::Preview
  def notify_user_about_new_comment
    question = Question.first
    user = User.first
    replier = User.last

    CommentMailer.with(question: question,
                       user: user,
                       replier: replier)
                 .notify_user_about_new_comment
  end
end
