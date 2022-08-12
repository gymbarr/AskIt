class QuestionsController < ApplicationController
  def index
    @questions = Question.all
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(title: params[:title], body: params[:body])

    if @question.save
      redirect_to questions_path
    else
      render 'new'
    end
  end
end