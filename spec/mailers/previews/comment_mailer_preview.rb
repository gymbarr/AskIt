# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/comment_mailer
class CommentMailerPreview < ActionMailer::Preview
  def notify_user_about_new_comment
    user = User.find_or_create_by(email: 'g-barr@mail.ru') do |new_user|
      new_user.username = 'Andrey'
      new_user.password = 'password'
    end

    replier = User.find_or_create_by(email: 'andrewtoms@mail.ru') do |new_user|
      new_user.username = 'Andrew Toms'
      new_user.password = 'password'
    end

    question = FactoryBot.create(:question, :with_categories, user: user)

    CommentMailer.with(question: question,
                       user: user,
                       replier: replier)
                 .notify_user_about_new_comment
  end
end
