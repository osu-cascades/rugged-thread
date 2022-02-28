class CreateStandardInventoryItems < ActiveRecord::Migration[7.0]
  def change
    create_table :standard_inventory_items do |t|
      t.string :name
      t.string :sku
      t.integer :price
      t.references :standard_repair, null: false, foreign_key: true

      t.timestamps
    end
  end
end
