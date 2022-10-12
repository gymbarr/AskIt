# frozen_string_literal: true

class RemoveUserFromQuestions < ActiveRecord::Migration[6.0]
  def change
    remove_column :questions, :user_id, :integer
  end
end
