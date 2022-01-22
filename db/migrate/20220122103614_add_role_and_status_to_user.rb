class AddRoleAndStatusToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :role, :integer, default: 0, null: false
    add_column :users, :status, :integer, default: 1, null: false
  end
end
