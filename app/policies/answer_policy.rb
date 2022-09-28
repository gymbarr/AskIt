class AnswerPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def update?
    @user.has_role?(:admin) || @user.author?(record)
  end

  def destroy?
    @user.has_role?(:admin) || @user.author?(record)
  end

  def create?
    true
  end

  def vote_up?
    true
  end

  def vote_down?
    true
  end
end
