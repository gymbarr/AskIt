module Runners
  class NewAnswerNotifyJob < ApplicationJob
    queue_as :notifiers

    def perform(answer_id)
      answer = Answer.find_by_id(answer_id)
      return unless answer

      question = answer.repliable
      user = question.user
      replier = answer.user

      AnswerMailer.with(question: question,
                        user: user,
                        replier: replier)
                  .new_answer_notify
                  .deliver_now
    end
  end
end
