# frozen_string_literal: true

class DropComments < ActiveRecord::Migration[6.0]
  # rubocop:disable Rails/ReversibleMigration
  def change
    drop_table :comments
  end
  # rubocop:enable Rails/ReversibleMigration
end
