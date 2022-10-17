# frozen_string_literal: true

class DropTableActiveAdminComments < ActiveRecord::Migration[6.0]
  # rubocop:disable Rails/ReversibleMigration
  def change
    drop_table :active_admin_comments
  end
  # rubocop:enable Rails/ReversibleMigration
end
