class SubscriptionsController < ApplicationController
  before_action :set_category, only: %i[create destroy]

  def create
    subscription = @category.subscriptions.build(user_id: current_user.id)

    if subscription.save
      redirect_to category_path(@category), notice: 'Subscribed successfully!'
    else
      redirect_to category_path(@category), alert: 'Something went wrong'
    end
  end

  def destroy
    subscription = Subscription.find_by(user_id: current_user, category_id: @category)

    if subscription.destroy
      redirect_to category_path(@category), notice: 'Unsubscribed!'
    else
      redirect_to category_path(@category), alert: 'Something went wrong'
    end
  end

  private

  def set_category
    @category = Category.find(params[:category_id])
  end

end