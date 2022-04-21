class RenameStandardInventoryItemPriceToPriceCents < ActiveRecord::Migration[7.0]
  def up
    rename_column :standard_inventory_items, :price, :price_cents
  end

  def down
    rename_column :standard_inventory_items, :price_cents, :price
  end
end
