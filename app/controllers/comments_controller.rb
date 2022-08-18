class CommentsController < ApplicationController
  include ActionView::RecordIdentifier

  before_action :set_question
  before_action :set_comment, except: %i[create]

  def create
    comment = current_user.comments.build(comment_params)

    if comment.save
      redirect_to question_path(@question, anchor: dom_id(comment)), notice: 'Comment was successfully added to the answer!'
    else
      redirect_to question_path(@question), alert: 'Something went wrong'
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
      redirect_to question_path(@question, anchor: dom_id(@comment)), notice: 'Comment was successfully updated!'
    else
      redirect_to question_path(@question), alert: 'Something went wrong'
    end
  end

  def destroy
    @comment.destroy
    redirect_to question_path(@question), notice: 'Comment was successfully deleted!'
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:body, :answer_id)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end
  
  def set_question
    @question = Question.find(params[:question_id])
  end
end