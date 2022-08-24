class NotifySubscriberJob < ApplicationJob
  queue_as :default

  def perform(params)
    UserMailer.with(user: params[:subscriber], category: params[:category], question: params[:question])
              .notify_subscriber.deliver_later
  end
end
