# frozen_string_literal: true

module Questions
  module Notifiers
    class CategorySubscribersNotifier < ApplicationService
      attr_reader :question

      def initialize(question)
        super
        @question = question
      end

      def call
        Kickers::NotifyCategorySubscribersJob.perform_later(@question.id)
      end
    end
  end
end
