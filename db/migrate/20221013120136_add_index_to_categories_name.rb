# frozen_string_literal: true

class AddIndexToCategoriesName < ActiveRecord::Migration[6.0]
  def change
    add_index :categories, :name, unique: true
  end
end
