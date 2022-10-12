# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authorize_comment!, only: %i[update destroy]
  after_action :verify_authorized

  def create
    authorize(Comment)
    comment = Comment.new(user: current_user, **comment_params)
    comment.parent = comment.repliable

    if comment.save
      # send notification to the repliable user
      Comments::Notifiers::NewCommentNotifier.call(comment)
      flash[:notice] = t('.success')
      redirect_to back_with_anchor anchor: "comment-#{comment.id}"
    else
      flash[:alert] = t('.alert')
      redirect_back fallback_location: root_path
    end
  end

  def update
    if comment.update(comment_params)
      flash[:notice] = t('.success')
    else
      flash[:alert] = t('.alert')
    end
    redirect_to back_with_anchor anchor: "comment-#{comment.id}"
  end

  def destroy
    if comment.destroy
      flash[:notice] = t('.success')
    else
      flash[:alert] = t('.alert')
    end
    redirect_back fallback_location: root_path
  end

  def load_more_comments
    authorize(Comment)
    @question = answer.repliable
    @pagy_comments, @comments = pagy_countless(answer.descendants.order(created_at: :asc), items: 5)

    respond_to do |format|
      format.html # GET
      format.turbo_stream # POST
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :repliable_id, :repliable_type, :type)
  end

  def comment
    @comment ||= Comment.find(params[:id])
  end

  def question
    @question ||= Question.find(params[:question_id])
  end

  def answer
    @answer ||= Answer.find(params[:answer_id])
  end

  def authorize_comment!
    authorize(comment)
  end
end
