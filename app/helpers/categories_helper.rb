# frozen_string_literal: true

module CategoriesHelper
  def already_subscribed?(category)
    return unless current_user

    Subscription.find_by(category: category, user: current_user)
  end
end
