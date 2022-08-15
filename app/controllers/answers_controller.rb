class AnswersController < ApplicationController
  before_action :set_answer, only: %i[destroy]
  before_action :set_question, only: %i[create destroy]

  def create
    answer = @question.answers.build(answer_params)

    if answer.save
      redirect_to question_path(@question), notice: 'Answer was successfully added to the question!'
    else
      render 'questions/show'
    end
  end

  def destroy
    @answer.destroy
    redirect_to question_path(@question), notice: 'Answer was successfully deleted!'
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end

  def set_answer
    @answer = Answer.find(params[:id])
  end

  def set_question
    @question = Question.find(params[:question_id])
  end
end