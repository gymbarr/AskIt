module ApplicationHelper
  include Pagy::Frontend
  
  def format_timestamp(timestamp, format = '%d-%m-%Y %H:%M:%S')
    timestamp.strftime(format)
  end

  def pagination(obj)
    raw(pagy_bootstrap_nav(obj)) if obj.pages > 1
  end

  def owner?(obj)
    obj.user == current_user
  end
end
