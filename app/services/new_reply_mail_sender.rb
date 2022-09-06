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
      Runners::MailAnswerToQuestionJob.perform_later(@question.id, @reply.id)
    when Answer
      Runners::MailCommentToAnswerJob.perform_later(@question.id, @reply.id)
    when Comment
      Runners::MailCommentToCommentJob.perform_later(@question.id, @reply.id)
    end
  end
end