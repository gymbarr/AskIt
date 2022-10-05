class ApplicationController < ActionController::Base
  include Pagy::Backend
  include Internationalization
  include Authorization
  include Authentication
  include ErrorHandling

  private

  def after_sign_in_path_for(resource)
    root_path(locale: current_user.locale)
  end

  protected

  def back_with_anchor(anchor: '')
    "#{request.referrer}##{anchor}"
  end
end
