class AddDiscardColumnToItemStatuses < ActiveRecord::Migration[7.0]
  def change
    add_column :item_statuses, :discarded_at, :datetime
    add_index :item_statuses, :discarded_at
  end
end
