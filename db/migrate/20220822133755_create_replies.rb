# frozen_string_literal: true

class CreateReplies < ActiveRecord::Migration[6.0]
  def change
    create_table :replies do |t|
      t.string :type
      t.text :body
      t.references :repliable, polymorphic: true
      t.belongs_to :user

      t.timestamps
    end
  end
end
