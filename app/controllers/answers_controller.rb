class AnswersController < ApplicationController
  include ActionView::RecordIdentifier
  before_action :answer, only: %i[edit]

  def create
    answer = question.answers.build(answer_params)
    answer.user = current_user

    if answer.save
      redirect_to question_path(question, anchor: dom_id(answer)), notice: 'Answer was successfully added to the question!'
    else
      redirect_to question_path(question), alert: 'Something went wrong'
    end
  end

  def edit
    @pagy, @answers = pagy question.answers.order(created_at: :desc), page: params[:page]

    respond_to do |format|
      format.js { render partial: 'questions/answer_form', locals: { objs: @answers, obj: @answer } }
    end
  end

  def update
    if answer.update(answer_params)
      redirect_to question_path(question, anchor: dom_id(answer)), notice: 'Answer was successfully updated!'
    else
      redirect_to question_path(question), alert: 'Something went wrong'
    end
  end

  def destroy
    answer.destroy
    redirect_to question_path(question), notice: 'Answer was successfully deleted!'
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
end
