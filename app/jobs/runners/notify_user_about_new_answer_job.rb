module Runners
  class NotifyUserAboutNewAnswerJob < ApplicationJob
    queue_as :runners_notifiers

    def perform(answer_id)
      answer = Answer.find_by_id(answer_id)
      return unless answer

      question = answer.repliable
      user = question.user
      replier = answer.user

      AnswerMailer.with(question: question,
                        user: user,
                        replier: replier)
                  .notify_user_about_new_answer
                  .deliver_now
    end
  end
end
