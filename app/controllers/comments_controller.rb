class CommentsController < ApplicationController
  before_action :set_answer, only: %i[create]
  before_action :set_question, only: %i[create]

  def create
    comment = @answer.comments.build(comment_params)

    if comment.save
      redirect_to question_path(@question), notice: 'Comment was successfully added to the answer!'
    else
      render 'questions/show'
    end
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:body)
  end
  
  def set_answer
    @answer = Answer.find(params[:answer_id])
  end
  
  def set_question
    @question = Question.find(params[:question_id])
  end
end