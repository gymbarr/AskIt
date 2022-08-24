class NotifySubscribersJob < ApplicationJob
  queue_as :default

  def perform(question)
    subscribers = question.subscribers
    category = question.categories.first
    return if subscribers.blank? || category.blank?

    params = { category: category, question: question }

    subscribers.each do |subscriber|
      # skip the author of the question if he is a subscriber
      next if question.user == subscriber

      params[:subscriber] = subscriber
      NotifySubscriberJob.perform_later(params)
    end
  end
end
