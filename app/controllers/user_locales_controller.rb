class UserLocalesController < ApplicationController
  def change_locale
    locale = params[:locale]
    host = ENV.fetch('HOST')

    current_user&.update(locale: locale)
    prev_path = request.referer
    new_path = prev_path.gsub(/http:\/\/#{Regexp.quote(host)}\/\w+/, "http://#{host}/#{locale}")

    redirect_to new_path
  end
end
