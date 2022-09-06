class AnswersController < ApplicationController
  def create
    answer = Answer.new(user: current_user, **answer_params)

    if answer.save
      # send notification to the repliable user
      # NewReplyMailSender.call(question, answer)
      flash[:notice] = t('.success')
      redirect_to back_with_anchor anchor: "reply-#{answer.id}"
    else
      flash[:alert] = t('.alert')
      redirect_back fallback_location: root_path
    end
  end

  def update
    if answer.update(answer_params)
      flash[:notice] = t('.success')
    else
      flash[:alert] = t('.alert')
    end
    redirect_back fallback_location: root_path
  end

  def destroy
    if answer.destroy
      flash[:notice] = t('.success')
    else
      flash[:alert] = t('.alert')
    end
    redirect_back fallback_location: root_path
  end

  def vote_up
    answer.vote_by voter: current_user, vote: 'like'
    redirect_to back_with_anchor anchor: "reply-#{answer.id}"
  end

  def vote_down
    answer.vote_by voter: current_user, vote: 'bad'
    redirect_to back_with_anchor anchor: "reply-#{answer.id}"
  end

  private

  def answer_params
    params.require(:answer).permit(:body, :repliable_id, :repliable_type, :type)
  end

  def answer
    @answer ||= Answer.find_by_id(params[:id]) || Answer.find_by_id(params[:answer_id])
  end

  def back_with_anchor(anchor: '')
    "#{request.referrer}##{anchor}"
  end
end
