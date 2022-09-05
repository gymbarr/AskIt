class NewCommentToCommentMailJob < ApplicationJob
  queue_as :default

  def perform(question, comment)
    NewCommentMailer.with(question: question, comment: comment).new_comment_to_comment.deliver_later
  end
end
