# frozen_string_literal: true

class CommentPolicy < ApplicationPolicy
  def update?
    admin? || author?
  end

  def destroy?
    admin? || author?
  end

  def create?
    true
  end

  def load_more_comments?
    true
  end
end
