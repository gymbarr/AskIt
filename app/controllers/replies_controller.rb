class RepliesController < ApplicationController
  def reply
    Reply.create(user: current_user, **reply_params)
    redirect_back fallback_location: root_path
  end

  def new
    replies = Reply.all
    repliable = Reply.find(params[:repliable_id])

    respond_to do |format|
      format.js { render partial: 'questions/new_reply_form', locals: { replies: replies, repliable: repliable } }
    end
  end

  private

  def reply_params
    params.require(:reply).permit(:body, :repliable_id, :repliable_type, :type)
  end
end
