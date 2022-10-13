# frozen_string_literal: true

class QuestionPolicy < ApplicationPolicy
  def edit?
    update?
  end

  def update?
    admin? || author?
  end

  def destroy?
    admin? || author?
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
