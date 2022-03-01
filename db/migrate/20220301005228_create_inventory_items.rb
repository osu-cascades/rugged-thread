class CreateInventoryItems < ActiveRecord::Migration[7.0]
  def change
    create_table :inventory_items do |t|
      t.integer :price
      t.references :repair, null: false, foreign_key: true
      t.references :standard_inventory_item, null: false, foreign_key: true

      t.timestamps
    end
  end
end
