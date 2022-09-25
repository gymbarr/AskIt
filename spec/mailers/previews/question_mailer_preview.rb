# Preview all emails at http://localhost:3000/rails/mailers/question_mailer
class QuestionMailerPreview < ActionMailer::Preview
  def notify_subscriber_about_new_question_in_category
    user = User.find_or_create_by(email: 'g-barr@mail.ru') do |new_user|
      new_user.username = 'Andrey'
      new_user.password = 'password'
    end

    categories = FactoryBot.create_list(:category, 3)
    categories_name = categories.map(&:name).join(', ')
    question = FactoryBot.create(:question,
                                 user: user,
                                 categories: categories)

    QuestionMailer.with(question: question,
                        user: user,
                        categories: categories,
                        categories_name: categories_name)
                  .notify_subscriber_about_new_question_in_category
  end
end
