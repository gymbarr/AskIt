module Kickers
  class NotifyCategorySubscribersJob < ApplicationJob
    queue_as :default

    def perform(question_id)
      question = Question.find_by_id(question_id)
      return unless question

      subscribers = question.subscribers
      return if subscribers.blank?

      subscribers.each do |subscriber|
        # skip the author of the question if he is a subscriber
        next if question.user == subscriber

        Runners::NotifyCategorySubscriberJob.perform_later(question_id, subscriber.id)
      end
    end
  end
end
