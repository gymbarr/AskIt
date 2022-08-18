class AnswersController < ApplicationController
  include ActionView::RecordIdentifier

  before_action :set_answer, only: %i[edit update destroy]
  before_action :set_question, only: %i[create edit update destroy]

  def create
    answer = current_user.answers.build(answer_params)

    if answer.save
      redirect_to question_path(@question, anchor: dom_id(answer)), notice: 'Answer was successfully added to the question!'
    else
      redirect_to question_path(@question), alert: 'Something went wrong'
    end
  end

  def edit
    @pagy, @answers = pagy @question.answers.order(created_at: :desc), page: params[:page]

    respond_to do |format|
      format.js { render partial: 'questions/answer_form' }
    end
  end

  def update
    if @answer.update(answer_params)
      redirect_to question_path(@question, anchor: dom_id(@answer)), notice: 'Answer was successfully updated!'
    else
      redirect_to question_path(@question), alert: 'Something went wrong'
    end
  end

  def destroy
    @answer.destroy
    redirect_to question_path(@question), notice: 'Answer was successfully deleted!'
  end

  private

  def answer_params
    params.require(:answer).permit(:body, :question_id)
  end

  def set_answer
    @answer = Answer.find(params[:id])
  end

  def set_question
    @question = Question.find(params[:question_id])
  end
end