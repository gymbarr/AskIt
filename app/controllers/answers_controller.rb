# frozen_string_literal: true

class AnswersController < ApplicationController
  before_action :authorize_answer!, only: %i[update destroy vote_up vote_down]
  after_action :verify_authorized

  def create
    authorize(Answer)
    answer = Answer.new(user: current_user, **answer_params)

    if answer.save
      # send notification to the repliable user
      Answers::Notifiers::NewAnswerNotifier.call(answer)
      flash[:notice] = t('.success')
      redirect_to back_with_anchor anchor: "answer-#{answer.id}"
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
    redirect_to back_with_anchor anchor: "answer-#{answer.id}"
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
    redirect_to back_with_anchor anchor: "answer-#{answer.id}"
  end

  def vote_down
    answer.vote_by voter: current_user, vote: 'bad'
    redirect_to back_with_anchor anchor: "answer-#{answer.id}"
  end

  private

  def answer_params
    params.require(:answer).permit(:body, :repliable_id, :repliable_type, :type)
  end

  def answer
    @answer ||= Answer.find(params[:id])
  end

  def question
    @question ||= Question.find(params[:question_id])
  end

  def authorize_answer!
    authorize(answer)
  end
end
