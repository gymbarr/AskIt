# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pagy::Backend
  include Internationalization
  include Authorization
  include Authentication
  include ErrorHandling

  private

  def back_with_anchor(anchor: '')
    "#{request.referer}##{anchor}"
  end
end
