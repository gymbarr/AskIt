class QuestionsController < ApplicationController
  before_action :question, only: %i[edit]

  def index
    @pagy, @questions = pagy Question.order(created_at: :desc)
  end

  def show
    @pagy, @answers = pagy question.answers.order(created_at: :desc)
    @page = params[:page]

    @answer = Answer.new
    @comment = Comment.new
  end

  def new
    @question = Question.new
  end

  def create
    question = current_user.questions.build(question_params)

    if question.save
      SubscriptionMailSender.call(question)
      redirect_to question_path(question), notice: 'Question was successfully created!'
    else
      redirect_to new_question_path, alert: 'Something went wrong'
    end
  end

  def edit; end

  def update
    if question.update(question_params)
      redirect_to question_path(question), notice: 'Question was successfully updated!'
    else
      redirect_to edit_question_path(question), alert: 'Something went wrong'
    end
  end

  def destroy
    question.destroy
    redirect_to questions_path, notice: 'Question was successfully deleted!'
  end

  def vote_up
    question_for_vote.vote_by voter: current_user, vote: 'like'
    redirect_to question_path(question_for_vote)
  end

  def vote_down
    question_for_vote.vote_by voter: current_user, vote: 'bad'
    redirect_to question_path(question_for_vote)
  end

  private

  def question_params
    params.require(:question).permit(:title, :body, :category_ids)
  end

  def question
    @question ||= Question.find(params[:id])
  end

  def question_for_vote
    @question_for_vote ||= Question.find(params[:question_id])
  end
end
