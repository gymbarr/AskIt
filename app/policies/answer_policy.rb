# frozen_string_literal: true

class AnswerPolicy < ApplicationPolicy
  def update?
    admin? || author?
  end

  def destroy?
    admin? || author?
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
