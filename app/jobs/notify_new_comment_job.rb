class NotifyNewCommentJob < ApplicationJob
  queue_as :default

  def perform(question, comment)
    NewCommentMailer.with(question: question, comment: comment).notify_new_comment.deliver_later
  end
end
