# frozen_string_literal: true

module Internationalization
  extend ActiveSupport::Concern

  included do
    before_action :switch_locale

    private

    def switch_locale
      locale = locale_from_url || locale_from_http_headers || I18n.default_locale
      I18n.locale = locale
    end

    def locale_from_url
      locale = params[:locale]

      return locale if I18n.available_locales.map(&:to_s).include?(locale)
    end

    def locale_from_http_headers
      # this methods provided by gem 'http_accept_language'
      http_accept_language.compatible_language_from(I18n.available_locales)
    end

    def default_url_options
      { locale: I18n.locale }
    end
  end
end
