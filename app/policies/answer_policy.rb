class AnswerPolicy < ApplicationPolicy
  def update?
    is_admin? || is_author?
  end

  def destroy?
    is_admin? || is_author?
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
