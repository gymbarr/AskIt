class QuestionsController < ApplicationController
  before_action :question, only: %i[edit]
  before_action :authorize_question!
  after_action :verify_authorized

  def index
    @pagy, @questions = pagy(Question.order(created_at: :desc), items: 5)
    render 'loaded_questions' if params[:page]
  end

  def show
    @pagy, @answers = pagy(question.answers.order(created_at: :desc), items: 2)
    @comments_per_page = 5

    render 'answers/loaded_answers' if params[:page]
  end

  def new
    @question = Question.new
  end

  def create
    question = current_user.questions.build(question_params)

    if question.save
      Questions::Notifiers::CategorySubscribersNotifier.call(question)
      redirect_to question_path(question), notice: t('.success')
    else
      redirect_to new_question_path, alert: t('.alert')
    end
  end

  def edit; end

  def update
    if question.update(question_params)
      redirect_to question_path(question, format: :html), notice: t('.success')
    else
      redirect_to edit_question_path(question), alert: t('.alert')
    end
  end

  def destroy
    question.destroy
    redirect_to questions_path(format: :html), notice: t('.success')
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
    @question ||= Question.includes(answers: :comments).find(params[:id])
  end

  def authorize_question!
    authorize(@question || Question)
  end
end
