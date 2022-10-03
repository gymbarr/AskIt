class CategoryPolicy < ApplicationPolicy
  def new?
    create?
  end

  def create?
    is_admin?
  end

  def edit?
    update?
  end

  def update?
    is_admin?
  end

  def destroy?
    is_admin?
  end

  def index?
    true
  end

  def show?
    true
  end
end
