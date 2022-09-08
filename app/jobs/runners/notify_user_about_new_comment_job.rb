module Runners
  class NotifyUserAboutNewCommentJob < ApplicationJob
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
                   .notify_user_about_new_comment
                   .deliver_now
    end
  end
end