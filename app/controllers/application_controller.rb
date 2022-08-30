class ApplicationController < ActionController::Base
  include Pagy::Backend
  include Internationalization
  helper_method :current_user, :logged_in?
  before_action :authenticate_user!
end
