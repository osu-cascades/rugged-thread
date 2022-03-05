class ReplaceItemTypeStringWithForeignKey < ActiveRecord::Migration[7.0]
  def up
    remove_column :quote_requests, :item_type
    add_reference :quote_requests, :item_type, foreign_key: true, null: false
  end

  def down
    remove_reference :quote_requests, :item_type
    add_column :quote_requests, :item_type, :string
  end
end
