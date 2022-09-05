module Runners
  class MailCommentToAnswerJob < ApplicationJob
    queue_as :default

    def perform(question_id, comment_id)
      CommentMailer.with(question_id: question_id, comment_id: comment_id)
                   .new_comment_to_answer
                   .deliver_now
    end
  end
end
