# frozen_string_literal: true

class DropTableUsers < ActiveRecord::Migration[6.0]
  def change
    drop_table :users
  end
end
