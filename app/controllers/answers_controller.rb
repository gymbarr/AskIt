class AnswersController < ApplicationController

  def create
    current_question = Question.find(params[:question_id])
    answer = current_question.answers.build(answer_params)

    if answer.save
      redirect_to question_path(current_question), notice: 'Answer was successfully added to the question!'
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end
end