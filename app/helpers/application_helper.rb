module ApplicationHelper
  include Pagy::Frontend
  
  def format_timestamp(timestamp, format = '%d-%m-%Y %H:%M:%S')
    timestamp.strftime(format)
  end
end
