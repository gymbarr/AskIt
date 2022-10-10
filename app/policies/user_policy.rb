class UserPolicy < ApplicationPolicy
  def change_locale?
    true
  end
end
