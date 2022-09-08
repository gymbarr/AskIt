module Questions
  module Notifier
    class CategorySubscribersNotifier < ApplicationService
      attr_reader :question

      def initialize(question)
        @question = question
      end

      def call
        Kickers::NotifyCategorySubscribersJob.perform_later(@question.id)
      end
    end
  end
end
