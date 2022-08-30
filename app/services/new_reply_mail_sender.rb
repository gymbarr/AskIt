class NewReplyMailSender < ApplicationService
  attr_reader :question, :reply

  def initialize(question, reply)
    @question = question
    @reply = reply
  end

  def call
    # don't notify if the replier is the author of the repliable
    return if @reply.repliable.user == @reply.user

    NotifyNewReplyJob.perform_now(@question, @reply)
  end
end
