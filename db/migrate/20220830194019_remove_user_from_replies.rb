# frozen_string_literal: true

class RemoveUserFromReplies < ActiveRecord::Migration[6.0]
  def change
    remove_column :replies, :user_id, :integer
  end
end
