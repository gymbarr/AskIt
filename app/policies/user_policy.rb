# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def change_locale?
    true
  end
end
