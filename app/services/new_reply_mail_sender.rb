class NewReplyMailSender < ApplicationService
  attr_reader :question, :reply

  def initialize(question, reply)
    @question = question
    @reply = reply
  end

  def call
    # don't notify if the replier is the author of the repliable
    return if @reply.repliable.user == @reply.user

    case reply.repliable
    when Question
      MailAnswerToQuestionJob.perform_later(@question, @reply)
    when Answer
      MailCommentToAnswerJob.perform_later(@question, @reply)
    when Comment
      MailCommentToCommentJob.perform_later(@question, @reply)
    end
  end
end
