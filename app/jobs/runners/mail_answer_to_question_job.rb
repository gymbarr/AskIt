module Runners
  class MailAnswerToQuestionJob < ApplicationJob
    queue_as :default

    def perform(question, answer)
      AnswerMailer.with(question: question, answer: answer).new_answer_to_question.deliver_now
    end
  end
end
