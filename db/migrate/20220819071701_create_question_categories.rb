# frozen_string_literal: true

class CreateQuestionCategories < ActiveRecord::Migration[6.0]
  # rubocop:disable Rails/CreateTableWithTimestamps
  def change
    create_table :question_categories do |t|
      t.integer :question_id
      t.integer :category_id
    end
  end
  # rubocop:enable Rails/CreateTableWithTimestamps
end
