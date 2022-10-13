# frozen_string_literal: true

class QuestionPolicy < ApplicationPolicy
  def edit?
    update?
  end

  def update?
    is_admin? || is_author?
  end

  def destroy?
    is_admin? || is_author?
  end

  def index?
    true
  end

  def show?
    true
  end

  def new?
    true
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
