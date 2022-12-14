# frozen_string_literal: true

class AddQuestionsCountToCategories < ActiveRecord::Migration[6.0]
  def change
    add_column :categories, :questions_count, :integer, default: 0, null: false
  end
end
