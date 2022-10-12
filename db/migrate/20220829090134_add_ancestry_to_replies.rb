# frozen_string_literal: true

class AddAncestryToReplies < ActiveRecord::Migration[6.0]
  def change
    add_column :replies, :ancestry, :string
    add_index :replies, :ancestry
  end
end
