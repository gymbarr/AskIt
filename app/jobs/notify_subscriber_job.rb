class NotifySubscriberJob < ApplicationJob
  queue_as :default

  def perform(params)
    SubscriptionMailer.with(user: subscriber, category: category, question: question)
                      .new_question_in_category.deliver_later
  end

  private

  def subscriber
    params[:subscriber]
  end

  def category
    params[:category]
  end

  def question
    params[:question]
  end
end
