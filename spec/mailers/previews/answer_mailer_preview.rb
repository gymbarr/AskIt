# Preview all emails at http://localhost:3000/rails/mailers/answer_mailer
class AnswerMailerPreview < ActionMailer::Preview
  def notify_user_about_new_answer
    question = Question.first
    user = User.first
    replier = User.last

    AnswerMailer.with(question: question,
                      user: user,
                      replier: replier)
                .notify_user_about_new_answer
  end
end
