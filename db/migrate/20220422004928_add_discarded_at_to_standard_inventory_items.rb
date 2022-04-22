class AddDiscardedAtToStandardInventoryItems < ActiveRecord::Migration[7.0]
  def change
    add_column :standard_inventory_items, :discarded_at, :datetime
    add_index :standard_inventory_items, :discarded_at
  end
end
