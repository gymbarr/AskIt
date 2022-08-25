class ApplicationController < ActionController::Base
  include Pagy::Backend
  include Internationalization
  helper_method :current_user, :logged_in?, :already_subscribed?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_user
    redirect_to new_session_path, alert: 'You must be signed in to perform that action' unless logged_in?
  end

  def already_subscribed?(category)
    category.subscribers.find_by_id(current_user&.id)
  end
end
