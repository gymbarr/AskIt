# frozen_string_literal: true

class AddUsernameToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :username, :string, default: '', null: false
  end
end
