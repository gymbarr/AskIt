class ApplicationController < ActionController::Base
  include Pagy::Backend
  helper_method :current_user, :logged_in?, :already_subscribed?

  around_action :switch_locale

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

  private

  def switch_locale(&action)
    locale = locale_from_url || I18n.default_locale
    I18n.with_locale locale, &action
  end

  def locale_from_url
    locale = params[:locale]

    return locale if I18n.available_locales.map(&:to_s).include?(locale)
  end

  def default_url_options
    { locale: I18n.locale }
  end
end
