module Runners
  class NewCommentNotifyJob < ApplicationJob
    queue_as :mailers

    def perform(question_id, comment_id)
      CommentMailer.with(question_id: question_id, comment_id: comment_id)
                   .new_comment_notify
                   .deliver_now
    end
  end
end
