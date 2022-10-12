# frozen_string_literal: true

class UsersController < ApplicationController
  def change_locale
    locale = params[:locale]
    current_user.update(locale: locale)

    redirect_back fallback_location: root_path
  end
end
