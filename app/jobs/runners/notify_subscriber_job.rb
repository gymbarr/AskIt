module Runners
  class NotifySubscriberJob < ApplicationJob
    queue_as :notifiers

    def perform(question_id, subscriber_id)
      question = Question.find_by_id(question_id)
      user = User.find_by_id(subscriber_id)
      return unless question || user

      categories = question.categories.where(id: user.subscription_categories)
      categories_name = categories.map(&:name).join(', ')

      QuestionMailer.with(user: user,
                          question: question,
                          categories: categories,
                          categories_name: categories_name)
                    .new_question_notify
                    .deliver_now
    end
  end
end
