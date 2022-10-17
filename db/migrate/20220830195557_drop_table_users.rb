# frozen_string_literal: true

class DropTableUsers < ActiveRecord::Migration[6.0]
  # rubocop:disable Rails/ReversibleMigration
  def change
    drop_table :users
  end
  # rubocop:enable Rails/ReversibleMigration
end
