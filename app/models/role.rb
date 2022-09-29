class Role < ApplicationRecord
  BASIC_USER_ROLE_NAME = :basic
  ADMIN_USER_ROLE_NAME = :admin

  has_and_belongs_to_many :users, join_table: :users_roles

  belongs_to :resource,
             polymorphic: true,
             optional: true

  validates :resource_type,
            inclusion: { in: Rolify.resource_types },
            allow_nil: true

  scopify

  class << self
    def basic_user
      find_by name: BASIC_USER_ROLE_NAME
    end
  end
end
