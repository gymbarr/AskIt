# frozen_string_literal: true

module Answers
  module Notifiers
    class NewAnswerNotifier < ApplicationService
      attr_reader :question, :answer

      def initialize(answer)
        @answer = answer
      end

      def call
        # don't notify if the replier is the author of the repliable
        return if @answer.repliable.user == @answer.user

        Runners::NotifyUserAboutNewAnswerJob.perform_later(@answer.id)
      end
    end
  end
end
