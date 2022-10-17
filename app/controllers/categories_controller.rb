# frozen_string_literal: true

class CategoriesController < ApplicationController
  CATEGORIES_PER_PAGE = 10
  QUESTIONS_PER_PAGE = 5

  before_action :authorize_category!, only: %i[show]
  after_action :verify_authorized

  def index
    authorize(Category)
    @pagy, @categories = pagy(Category.order(created_at: :desc), items: CATEGORIES_PER_PAGE)

    render 'loaded_categories' if params[:page]
  end

  def show
    @pagy, @questions = pagy(category.questions
                                     .order(created_at: :desc)
                                     .includes(%i[user categories question_categories]), items: QUESTIONS_PER_PAGE)
    @subscription = Subscription.find_by(user: current_user, category: category)

    render 'loaded_category_questions' if params[:page]
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def category
    @category ||= Category.find(params[:id])
  end

  def authorize_category!
    authorize(category)
  end
end
