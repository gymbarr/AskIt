class NotifyNewReplyJob < ApplicationJob
  queue_as :default

  def perform(question, reply)
    UserMailer.with(question: question, reply: reply).notify_new_reply.deliver_now
  end
end
