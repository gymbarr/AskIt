class CommentsController < ApplicationController
  include Comments
  before_action :require_same_user, except: %i[create]

  def create
    comment = Comment.new(user: current_user, **comment_params)
    comment.parent = comment.repliable

    if comment.save
      # send notification to the repliable user
      Comments::Notifier::NewCommentNotifier.call(comment)
      flash[:notice] = t('.success')
      redirect_to back_with_anchor anchor: "reply-#{comment.id}"
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
    redirect_to back_with_anchor anchor: "reply-#{comment.id}"
  end

  def destroy
    if comment.destroy
      flash[:notice] = t('.success')
    else
      flash[:alert] = t('.alert')
    end
    redirect_back fallback_location: root_path
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

  def require_same_user
    flash[:alert] = t('.require_same_user.alert')
    redirect_back fallback_location: root_path if current_user != comment.user
  end
end
