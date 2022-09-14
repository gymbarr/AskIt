# Preview all emails at http://localhost:3000/rails/mailers/question_mailer
class QuestionMailerPreview < ActionMailer::Preview
  def notify_subscriber_about_new_question_in_category
    question = Question.first
    user = User.first
    categories = question.categories
    categories_name = categories.map(&:name).join(', ')

    QuestionMailer.with(question: question,
                        user: user,
                        categories: categories,
                        categories_name: categories_name)
                  .notify_subscriber_about_new_question_in_category
  end
end
