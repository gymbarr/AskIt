class CategoriesController < ApplicationController
  before_action :set_category, only: [:edit, :update, :destroy, :show]

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to @category, notice: "Category \"#{@category.name}\" was successfully created!"
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @category.update(category_params)
      flash[:notice] = "Category was updated successfully!"
      redirect_to @category, notice: "Category was updated successfully!"
    else
      render 'edit'
    end
  end

  def destroy
    @category.destroy
    redirect_to categories_path, notice: "The category was successfully deleted"
  end

  def index
    @pagy, @categories = pagy Category.all
  end

  def show
    # @articles = @category.articles.paginate(page: params[:page], per_page: 5)
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def set_category
    @category = Category.find(params[:id])
  end

end