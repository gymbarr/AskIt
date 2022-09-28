class CategoryPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def new?
    create?
  end

  def create?
    @user.has_role? :admin
  end

  def edit?
    update?
  end

  def update?
    @user.has_role? :admin
  end

  def destroy?
    @user.has_role? :admin
  end

  def index?
    true
  end

  def show?
    true
  end
end
