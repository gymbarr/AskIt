class CommentsController < ApplicationController
  include ActionView::RecordIdentifier

  before_action :question, only: %i[edit]
  before_action :comment, only: %i[edit]

  def create
    # comment = current_user.comments.build(comment_params)
    comment = answer.comments.build(comment_params)
    comment.user = current_user

    if comment.save
      redirect_to question_path(question, anchor: dom_id(comment)), notice: 'Comment was successfully added to the answer!'
    else
      redirect_to question_path(question), alert: 'Something went wrong'
    end
  end

  def edit
    @answer = comment.reply
    @comments = @answer.comments

    respond_to do |format|
      format.js { render partial: 'questions/reply_form', locals: { replies: @comments, obj: @comment } }
    end
  end

  def update
    if comment.update(comment_params)
      redirect_to question_path(question, anchor: dom_id(comment)), notice: 'Comment was successfully updated!'
    else
      redirect_to question_path(question), alert: 'Something went wrong'
    end
  end

  def destroy
    comment.destroy
    redirect_to question_path(question), notice: 'Comment was successfully deleted!'
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def comment
    @comment ||= Comment.find(params[:id])
  end

  def answer
    @answer ||= Answer.find(params[:answer_id])
  end

  def question
    @question ||= Question.find(params[:question_id])
  end
end
