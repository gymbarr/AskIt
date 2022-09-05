class NewCommentToAnswerMailJob < ApplicationJob
  queue_as :default

  def perform(question, comment)
    NewCommentMailer.with(question: question, comment: comment).new_comment_to_answer.deliver_later
  end
end
