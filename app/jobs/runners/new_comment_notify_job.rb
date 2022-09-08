module Runners
  class NewCommentNotifyJob < ApplicationJob
    queue_as :notifiers

    def perform(comment_id)
      comment = Comment.find(comment_id)
      return unless comment

      question = comment.root.repliable
      user = comment.repliable.user
      replier = comment.user

      CommentMailer.with(question: question,
                         user: user,
                         replier: replier)
                   .new_comment_notify
                   .deliver_now
    end
  end
end
