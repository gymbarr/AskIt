class ApplicationController < ActionController::Base
  include Pagy::Backend
  include Internationalization
  include Authorization
  include Authentication
  include ErrorHandling

  private

  def back_with_anchor(anchor: '')
    "#{request.referrer}##{anchor}"
  end
end
