class MailCommentToCommentJob < ApplicationJob
  queue_as :default

  def perform(question, comment)
    CommentMailer.with(question: question, comment: comment).new_comment_to_comment.deliver_now
  end
end
