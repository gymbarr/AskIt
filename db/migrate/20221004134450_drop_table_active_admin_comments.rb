class DropTableActiveAdminComments < ActiveRecord::Migration[6.0]
  def change
    drop_table :active_admin_comments
  end
end
