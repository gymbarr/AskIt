module Kickers
  class NotifySubscribersJob < ApplicationJob
    queue_as :default

    def perform(question_id)
      question = Question.find_by_id(question_id)
      return unless question

      subscribers = question.subscribers
      return if subscribers.blank?

      params = { question_id: question_id }

      subscribers.each do |subscriber|
        # skip the author of the question if he is a subscriber
        next if question.user == subscriber

        params[:subscriber_id] = subscriber.id
        Runners::NotifySubscriberJob.perform_later(params)
      end
    end
  end
end
