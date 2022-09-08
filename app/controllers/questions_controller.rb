class QuestionsController < ApplicationController
  include Questions
  before_action :question, only: %i[edit]

  def index
    @questions = Question.order(created_at: :desc)
  end

  def show
    @replies = question.answers.order(created_at: :desc).flat_map(&:subtree)
  end

  def new
    @question = Question.new
  end

  def create
    question = current_user.questions.build(question_params)

    if question.save
      Questions::NewQuestionNotifier.call(question)
      redirect_to question_path(question), notice: t('.success')
    else
      redirect_to new_question_path, alert: t('.alert')
    end
  end

  def edit; end

  def update
    if question.update(question_params)
      redirect_to question_path(question), notice: t('.success')
    else
      redirect_to edit_question_path(question), alert: t('.alert')
    end
  end

  def destroy
    question.destroy
    redirect_to questions_path, notice: t('.success')
  end

  def vote_up
    question.vote_by voter: current_user, vote: 'like'
    redirect_to question_path(question)
  end

  def vote_down
    question.vote_by voter: current_user, vote: 'bad'
    redirect_to question_path(question)
  end

  private

  def question_params
    params.require(:question).permit(:title, :body, category_ids: [])
  end

  def question
    @question ||= Question.find(params[:id])
  end
end
