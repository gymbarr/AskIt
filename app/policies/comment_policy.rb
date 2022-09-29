class CommentPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def update?
    is_admin? || is_author?
  end

  def destroy?
    is_admin? || is_author?
  end

  def create?
    true
  end
end
