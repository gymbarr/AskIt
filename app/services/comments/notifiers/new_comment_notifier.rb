# frozen_string_literal: true

module Comments
  module Notifiers
    class NewCommentNotifier < ApplicationService
      attr_reader :comment

      def initialize(comment)
        @comment = comment
      end

      def call
        # don't notify if the replier is the author of the repliable
        return if @comment.repliable.user == @comment.user

        Runners::NotifyUserAboutNewCommentJob.perform_later(@comment.id)
      end
    end
  end
end
