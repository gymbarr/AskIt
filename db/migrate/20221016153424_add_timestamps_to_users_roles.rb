# frozen_string_literal: true

class AddTimestampsToUsersRoles < ActiveRecord::Migration[6.0]
  def change
    change_table :users_roles, bulk: true, &:timestamps
  end
end
