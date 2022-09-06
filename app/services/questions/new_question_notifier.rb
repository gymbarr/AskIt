module Questions
  class NewQuestionNotifier < ApplicationService
    attr_reader :question

    def initialize(question)
      @question = question
    end

    def call
      Kickers::NotifySubscribersJob.perform_later(@question.id)
    end
  end
end
