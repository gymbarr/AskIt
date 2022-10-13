# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend
  include PoliciesHelper

  def format_timestamp(timestamp)
    # localise timestamp with the method of rails-i18n gem
    l timestamp, format: :long
  end

  def pagination(obj)
    raw(pagy_bootstrap_nav(obj)) if obj.pages > 1
  end
end
