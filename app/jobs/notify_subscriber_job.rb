class NotifySubscriberJob < ApplicationJob
  queue_as :default

  def perform(params)
    SubscriptionMailer.with(user: params[:subscriber], category: params[:category], question: params[:question])
                      .new_question_in_category.deliver_now
  end
end
