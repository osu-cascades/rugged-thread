class RemoveAdminPermissionFromUsers < ActiveRecord::Migration[6.1]
  def up
    remove_column :users, :admin
    remove_column :users, :permission
  end

  def down
    add_column :users, :admin, :boolean
    add_column :users, :permission, :string
  end
end
