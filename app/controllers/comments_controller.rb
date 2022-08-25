class CommentsController < ApplicationController
  include ActionView::RecordIdentifier

  before_action :question, only: %i[edit]
  before_action :comment, only: %i[edit]
  before_action :require_user
  before_action :require_same_user, only: %i[edit update destroy]

  def new
    @answers = question.answers
    @comment = Comment.new

    respond_to do |format|
      format.js { render partial: 'questions/new_reply_form', locals: { replies: @answers, obj: answer } }
    end
  end

  def create
    comment = answer.comments.build(comment_params)
    comment.user = current_user

    if comment.save
      redirect_to question_path(question, anchor: dom_id(comment)), notice: t('.success')
    else
      redirect_to question_path(question), alert: t('.alert')
    end
  end

  def edit
    @answer = comment.reply
    @comments = @answer.comments

    respond_to do |format|
      format.js { render partial: 'questions/edit_reply_form', locals: { replies: @comments, obj: @comment } }
    end
  end

  def update
    if comment.update(comment_params)
      redirect_to question_path(question, anchor: dom_id(comment)), notice: t('.success')
    else
      redirect_to question_path(question), alert: t('.alert')
    end
  end

  def destroy
    comment.destroy
    redirect_to question_path(question), notice: t('.success')
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

  def require_same_user
    redirect_to question, alert: t('comments.require_same_user.alert') if current_user != comment.user
  end
end
