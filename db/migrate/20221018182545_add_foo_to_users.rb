class AddFooToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :foo, :string, null: false, default: ''
  end
end
