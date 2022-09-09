class ApplicationController < ActionController::Base
  include Pagy::Backend
  include Internationalization
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username])
  end

  def back_with_anchor(anchor: '')
    "#{request.referrer}##{anchor}"
  end

  def record_not_found
    render plain: '404 Not Found', status: 404
  end
end
