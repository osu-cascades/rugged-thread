class AddDefaultToItemStatus < ActiveRecord::Migration[6.1]
  def up
    add_column :item_statuses, :default, :boolean, default: false
    add_index :item_statuses, :default, unique: true, where: '("default" IS TRUE)'
  end

  def down
    remove_column :item_statuses, :default
  end

end
