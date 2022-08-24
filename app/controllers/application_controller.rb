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
    category.subscribers.find_by_id(current_user.id)
  end
end
