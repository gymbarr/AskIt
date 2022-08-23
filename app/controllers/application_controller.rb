class ApplicationController < ActionController::Base
  include Pagy::Backend
  helper_method :current_user, :logged_in?, :already_subscribed?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def already_subscribed?(category)
    current_user.subscriptions.where(category_id: category.id).first
  end

  def notify_subscribers_new_question(question)
    # TODO: realization through question.subscribers
    category = question.categories.first
    subscriptions = category&.subscriptions
    return if category.blank? || subscriptions.blank?

    subscriptions.each do |subscription|
      user = subscription.user
      category = subscription.category
      NotifySubscribersMailer.with(user: user, category: category).notify_subscriber.deliver_later
    end
  end
end
