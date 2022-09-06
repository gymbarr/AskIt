module Runners
  class NotifySubscriberJob < ApplicationJob
    queue_as :mailers

    def perform(params)
      QuestionMailer.with(user_id: params[:subscriber_id], question_id: params[:question_id])
                        .new_question_notify
                        .deliver_now
    end
  end
end
