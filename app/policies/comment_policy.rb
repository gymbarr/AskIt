# frozen_string_literal: true

class CommentPolicy < ApplicationPolicy
  def update?
    is_admin? || is_author?
  end

  def destroy?
    is_admin? || is_author?
  end

  def create?
    true
  end

  def load_more_comments?
    true
  end
end
