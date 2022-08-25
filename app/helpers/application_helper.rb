module ApplicationHelper
  include Pagy::Frontend

  def format_timestamp(timestamp)
    # localise timestamp with the method of rails-i18n gem
    l timestamp, format: :long
  end

  def pagination(obj)
    raw(pagy_bootstrap_nav(obj)) if obj.pages > 1
  end

  def owner?(obj)
    obj.user == current_user
  end
end
