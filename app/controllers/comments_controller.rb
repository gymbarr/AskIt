class CommentsController < ApplicationController
  before_action :set_question
  before_action :set_answer, only: %i[create]
  before_action :set_comment, except: %i[create]

  def create
    comment = @answer.comments.build(comment_params)

    if comment.save
      redirect_to question_path(@question), notice: 'Comment was successfully added to the answer!'
    else
      render 'questions/show'
    end
  end

  def edit
    @answer = @comment.answer
    @comments = @answer.comments

    respond_to do |format|
      format.js { render partial: 'questions/comment_form' }
    end
  end

  def update
    if @comment.update(comment_params)
      redirect_to question_path(@question), notice: 'Comment was successfully updated!'
    else
      render 'questions/show'
    end
  end

  def destroy
    @comment.destroy
    redirect_to question_path(@question), notice: 'Comment was successfully deleted!'
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:body)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end
  
  def set_answer
    @answer = Answer.find(params[:answer_id])
  end
  
  def set_question
    @question = Question.find(params[:question_id])
  end
end