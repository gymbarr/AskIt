class NotifyNewReplyJob < ApplicationJob
  queue_as :default

  def perform(question, answer)
    UserMailer.with(question: question, answer: answer).notify_new_reply.deliver_later
  end
end
