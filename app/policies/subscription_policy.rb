# frozen_string_literal: true

class SubscriptionPolicy < ApplicationPolicy
  def create?
    true
  end

  def destroy?
    true
  end
end
