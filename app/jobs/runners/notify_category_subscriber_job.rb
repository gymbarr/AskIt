module Runners
  class NotifyCategorySubscriberJob < ApplicationJob
    queue_as :notifiers

    def perform(question_id, subscriber_id)
      question = Question.find_by_id(question_id)
      return unless question

      user = User.find_by_id(subscriber_id)
      return unless user

      categories = question.categories.where(id: user.subscription_categories)
      categories_name = categories.map(&:name).join(', ')

      QuestionMailer.with(user: user,
                          question: question,
                          categories: categories,
                          categories_name: categories_name)
                    .notify_subscriber_about_new_question_in_category
                    .deliver_now
    end
  end
end
