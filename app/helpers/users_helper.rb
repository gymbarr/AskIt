module UsersHelper
  def is_admin?
    return unless user_signed_in?

    current_user.has_role?(:admin)
  end
end
