# frozen_string_literal: true

class AddAncestryToQuestions < ActiveRecord::Migration[6.0]
  def change
    add_column :questions, :ancestry, :string
    add_index :questions, :ancestry
  end
end
