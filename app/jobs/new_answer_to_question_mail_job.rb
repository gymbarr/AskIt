class NewAnswerToQuestionMailJob < ApplicationJob
  queue_as :default

  def perform(question, answer)
    NewAnswerMailer.with(question: question, answer: answer).new_answer_to_question.deliver_later
  end
end
