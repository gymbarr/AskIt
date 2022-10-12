# frozen_string_literal: true

class RemoveUserFromSubscriptions < ActiveRecord::Migration[6.0]
  def change
    remove_column :subscriptions, :user_id, :integer
  end
end
