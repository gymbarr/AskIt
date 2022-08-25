class NewReplyMailSender < ApplicationService
  attr_reader :question, :answer

  def initialize(question, answer)
    @question = question
    @answer = answer
  end

  def call
    # don't notify if the replier is the author of the question
    return if @question.user == @answer.user

    NotifyNewReplyJob.perform_later(@question, @answer)
  end
end
