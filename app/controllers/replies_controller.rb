class RepliesController < ApplicationController
  def new
    respond_to do |format|
      format.js do
        render partial: 'questions/new_reply_form', locals: { repliable: repliable, new_reply: true }
      end
    end
  end

  def create
    reply = Reply.new(user: current_user, **reply_params)
    reply.parent = reply.repliable if reply.is_a?(Comment)
    reply.save
    redirect_back fallback_location: root_path
  end

  def edit
    respond_to do |format|
      format.js do
        render partial: 'questions/new_reply_form', locals: { repliable: repliable, new_reply: false }
      end
    end
  end

  def update
    reply = Reply.find(params[:id])

    if reply.update(reply_params)
      redirect_back fallback_location: root_path
    else
      redirect_back fallback_location: root_path, alert: 'Something went wrong'
    end
  end

  private

  def reply_params
    params.require(:reply).permit(:body, :repliable_id, :repliable_type, :type)
  end

  def question
    @question ||= Question.find(params[:question_id])
  end

  def replies
    @pagy, answers = pagy question.answers.order(created_at: :desc), page: params[:page]
    answers.flat_map(&:subtree)
  end

  def repliable
    Reply.find(params[:repliable_id])
  end
end
