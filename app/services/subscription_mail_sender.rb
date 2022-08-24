class SubscriptionMailSender < ApplicationService
  attr_reader :question

  def initialize(question)
    @question = question
  end

  def call
    NotifySubscribersJob.perform_later(@question)
  end
end
