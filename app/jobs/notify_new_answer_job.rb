class NotifyNewAnswerJob < ApplicationJob
  queue_as :default

  def perform(question, answer)
    NewAnswerMailer.with(question: question, answer: answer).notify_new_answer.deliver_later
  end
end
