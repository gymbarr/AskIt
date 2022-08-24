class NewReplyMailSender < ApplicationService
  attr_reader :question, :answer

  def initialize(question, answer)
    @question = question
    @answer = answer
  end

  def call
    NotifyNewReplyJob.perform_later(@question, @answer)
  end
end
