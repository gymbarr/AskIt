module Kickers
  class NotifyCategorySubscribersJob < ApplicationJob
    queue_as :default

    def perform(question_id)
      question = Question.find_by_id(question_id)
      return unless question

      subscribers = question.subscribers_without_author
      return if subscribers.blank?

      subscribers.each do |subscriber|
        Runners::NotifyCategorySubscriberJob.perform_later(question_id, subscriber.id)
      end
    end
  end
end
