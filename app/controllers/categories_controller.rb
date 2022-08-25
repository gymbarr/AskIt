class CategoriesController < ApplicationController
  before_action :category, only: %i[edit show]
  before_action :require_user, except: %i[index show]

  def new
    @category = Category.new
  end

  def create
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
    @pagy, @categories = pagy Category.all
  end

  def show
    @pagy, @questions = pagy category.questions.order(created_at: :desc)
    @subscription = Subscription.find_by(user_id: current_user, category_id: category)
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def category
    @category ||= Category.find(params[:id])
  end
end
