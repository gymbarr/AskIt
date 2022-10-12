# frozen_string_literal: true

class CategoryPolicy < ApplicationPolicy
  def new?
    create?
  end

  def create?
    admin?
  end

  def edit?
    update?
  end

  def update?
    admin?
  end

  def destroy?
    admin?
  end

  def index?
    true
  end

  def show?
    true
  end
end
