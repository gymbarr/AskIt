class SubscriptionsController < ApplicationController
  before_action :require_user

  def create
    subscription = category.subscriptions.build(user_id: current_user.id)

    if subscription.save
      redirect_to category_path(category), notice: t('.success')
    else
      redirect_to category_path(category), alert: t('.alert')
    end
  end

  def destroy
    if subscription.destroy
      redirect_to category_path(category), notice: t('.success')
    else
      redirect_to category_path(category), alert: t('.alert')
    end
  end

  private

  def subscription
    @subscription ||= Subscription.find(params[:id])
  end

  def category
    @category ||= Category.find(params[:category_id])
  end
end
