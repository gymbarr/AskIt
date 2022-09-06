module Comments
  class NewCommentNotifier < ApplicationService
    attr_reader :question, :comment

    def initialize(question, comment)
      @question = question
      @comment = comment
    end

    def call
      # don't notify if the replier is the author of the repliable
      return if @comment.repliable.user == @comment.user

      Runners::NewCommentNotifyJob.perform_later(@question.id, @comment.id)
    end
  end
end
