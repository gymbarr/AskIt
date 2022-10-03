class CategoriesController < ApplicationController
  before_action :authorize_category!, only: %i[edit update destroy show]
  after_action :verify_authorized

  def new
    authorize(Category)
    @category = Category.new
  end

  def create
    authorize(Category)
    @category = Category.new(category_params)

    if @category.save
      redirect_to @category, notice: t('.success')
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if category.update(category_params)
      redirect_to category, notice: t('.success')
    else
      render 'edit'
    end
  end

  def destroy
    category.destroy
    redirect_to categories_path, notice: t('.success')
  end

  def index
    authorize(Category)
    @pagy, @categories = pagy(Category.order(created_at: :desc), items: 10)

    render 'loaded_categories' if params[:page]
  end

  def show
    @pagy, @questions = pagy(category.questions.order(created_at: :desc), items: 5)
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
