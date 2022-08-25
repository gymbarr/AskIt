class AnswersController < ApplicationController
  include ActionView::RecordIdentifier

  before_action :answer, only: %i[edit]
  before_action :require_user
  before_action :require_same_user, only: %i[edit update destroy]

  def create
    answer = question.answers.build(answer_params)
    answer.user = current_user

    if answer.save
      # send notification to the author of question
      NewReplyMailSender.call(question, answer)
      redirect_to question_path(question, anchor: dom_id(answer)), notice: t('.success')
    else
      redirect_to question_path(question), alert: t('.alert')
    end
  end

  def edit
    @pagy, @answers = pagy question.answers.order(created_at: :desc), page: params[:page]

    respond_to do |format|
      format.js { render partial: 'questions/edit_reply_form', locals: { replies: @answers, obj: @answer } }
    end
  end

  def update
    if answer.update(answer_params)
      redirect_to question_path(question, anchor: dom_id(answer)), notice: t('.success')
    else
      redirect_to question_path(question), alert: t('.alert')
    end
  end

  def destroy
    answer.destroy
    redirect_to question_path(question), notice: t('.success')
  end

  def vote_up
    answer.vote_by voter: current_user, vote: 'like'
    redirect_to question_path(question, anchor: dom_id(answer))
  end

  def vote_down
    answer.vote_by voter: current_user, vote: 'bad'
    redirect_to question_path(question, anchor: dom_id(answer))
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end

  def answer
    @answer ||= Answer.find(params[:id])
  end

  def question
    @question ||= Question.find(params[:question_id])
  end

  def require_same_user
    redirect_to question, alert: t('answers.require_same_user.alert') if current_user != answer.user
  end
end
