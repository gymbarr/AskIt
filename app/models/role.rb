# frozen_string_literal: true

class Role < ApplicationRecord
  BASIC_USER_ROLE_NAME = :basic
  ADMIN_USER_ROLE_NAME = :admin

  # rubocop:disable Rails/HasAndBelongsToMany
  has_and_belongs_to_many :users, join_table: :users_roles
  # rubocop:enable Rails/HasAndBelongsToMany

  belongs_to :resource,
             polymorphic: true,
             optional: true

  validates :resource_type,
            inclusion: { in: Rolify.resource_types },
            allow_nil: true

  scopify

  class << self
    def basic_user_role
      BASIC_USER_ROLE_NAME
    end
  end

  class << self
    def admin_user_role
      ADMIN_USER_ROLE_NAME
    end
  end
end
