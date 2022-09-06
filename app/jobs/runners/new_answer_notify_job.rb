module Runners
  class NewAnswerNotifyJob < ApplicationJob
    queue_as :mailers

    def perform(question_id, answer_id)
      AnswerMailer.with(question_id: question_id, answer_id: answer_id)
                  .new_answer_notify
                  .deliver_now
    end
  end
end
