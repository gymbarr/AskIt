class RepliesController < ApplicationController
  def new
    respond_to do |format|
      format.js do
        render partial: 'questions/reply_form', locals: { repliable: repliable, new_reply: true }
      end
    end
  end

  def create
    reply = Reply.new(user: current_user, **reply_params)
    reply.parent = reply.repliable if reply.is_a?(Comment)

    if reply.save
      # send notification to the author of question
      NewReplyMailSender.call(question, reply)
      flash[:notice] = t('.success')
      redirect_to back_with_anchor anchor: "reply-#{reply.id}"
    else
      flash[:alert] = t('.alert')
      redirect_back fallback_location: root_path
    end
  end

  def edit
    respond_to do |format|
      format.js do
        render partial: 'questions/reply_form', locals: { repliable: repliable, new_reply: false }
      end
    end
  end

  def update
    if reply.update(reply_params)
      flash[:notice] = t('.success')
    else
      flash[:alert] = t('.alert')
    end
    redirect_back fallback_location: root_path
  end

  def destroy
    if reply.destroy
      flash[:notice] = t('.success')
    else
      flash[:alert] = t('.alert')
    end
    redirect_back fallback_location: root_path
  end

  def vote_up
    reply.vote_by voter: current_user, vote: 'like'
    redirect_to back_with_anchor anchor: "reply-#{reply.id}"
  end

  def vote_down
    reply.vote_by voter: current_user, vote: 'bad'
    redirect_to back_with_anchor anchor: "reply-#{reply.id}"
  end

  private

  def reply_params
    params.require(:reply).permit(:body, :repliable_id, :repliable_type, :type)
  end

  def question
    @question ||= Question.find(params[:question_id])
  end

  def reply
    @reply ||= Reply.find_by_id(params[:id]) || Reply.find_by_id(params[:reply_id])
  end

  def replies
    answers = question.answers.order(created_at: :desc)
    answers.flat_map(&:subtree)
  end

  def repliable
    @repliable ||= Reply.find(params[:repliable_id])
  end

  def back_with_anchor(anchor: '')
    "#{request.referrer}##{anchor}"
  end
end
