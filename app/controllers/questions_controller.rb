class QuestionsController < ApplicationController
  before_action :set_question, only: %i[show edit update destroy]
  before_action :set_question_for_vote, only: %i[vote_up vote_down]

  def index
    @pagy, @questions = pagy Question.order(created_at: :desc)
  end

  def show
    @pagy, @answers = pagy @question.answers.order(created_at: :desc)
    @page = params[:page]

    @answer = Answer.new
    @comment = Comment.new
  end

  def new
    @question = Question.new
  end

  def create
    @question = current_user.questions.build(question_params)

    if @question.save
      redirect_to question_path(@question), notice: 'Question was successfully created!'
    else
      redirect_to new_question_path, alert: 'Something went wrong'
    end
  end

  def edit; end

  def update
    byebug
    if @question.update(question_params)
      redirect_to questions_path, notice: 'Question was successfully updated!'
    else
      redirect_to edit_question_path, alert: 'Something went wrong'
    end
  end

  def destroy
    @question.destroy
    redirect_to questions_path, notice: 'Question was successfully deleted!'
  end

  def vote_up
    @question.vote_by voter: current_user, vote: 'like'
    redirect_to question_path(@question)
  end

  def vote_down
    @question.vote_by voter: current_user, vote: 'bad'
    redirect_to question_path(@question)
  end

  private

  def question_params
    params.require(:question).permit(:title, :body)
  end

  def set_question
    @question = Question.find(params[:id])
  end

  def set_question_for_vote
    @question = Question.find(params[:question_id])
  end
end