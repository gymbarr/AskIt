# frozen_string_literal: true

class DropAnswers < ActiveRecord::Migration[6.0]
  # rubocop:disable Rails/ReversibleMigration
  def change
    drop_table :answers
  end
  # rubocop:enable Rails/ReversibleMigration
end
