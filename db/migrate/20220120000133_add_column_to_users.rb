class AddColumnToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :name, :string
    add_column :users, :admin, :bool
    add_column :users, :permission, :string
    add_column :users, :end_date, :date
    add_column :users, :efficiency, :float
  end
end
