module Runners
  class NotifySubscriberJob < ApplicationJob
    queue_as :mailers

    def perform(params)
      SubscriptionMailer.with(user_id: params[:subscriber_id], question_id: params[:question_id])
                        .new_question_in_category
                        .deliver_now
    end
  end
end
