module Runners
  class MailAnswerToQuestionJob < ApplicationJob
    queue_as :default

    def perform(question_id, answer_id)
      AnswerMailer.with(question_id: question_id, answer_id: answer_id)
                  .new_answer_to_question
                  .deliver_now
    end
  end
end
