class RemoveRoleColumnFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :role, default: 0, null: false
  end
end
