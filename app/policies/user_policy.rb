class UserPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def edit?
    update?
  end

  def update?
    is_admin?
  end

  def index?
    is_admin?
  end

  def destroy?
    is_admin?
  end
end
