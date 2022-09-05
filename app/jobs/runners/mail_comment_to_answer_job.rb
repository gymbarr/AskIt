module Runners
  class MailCommentToAnswerJob < ApplicationJob
    queue_as :default

    def perform(question, comment)
      CommentMailer.with(question: question, comment: comment).new_comment_to_answer.deliver_now
    end
  end
end
