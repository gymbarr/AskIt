# frozen_string_literal: true

module UsersHelper
  def admin?
    return unless user_signed_in?

    current_user.has_role?(Role.admin_user_role)
  end
end
