class AddDiscardColumnToItemTypes < ActiveRecord::Migration[7.0]
  def change
    add_column :item_types, :discarded_at, :datetime
    add_index :item_types, :discarded_at
  end
end
