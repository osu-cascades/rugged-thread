class RenameInventoryItemPriceToPriceCents < ActiveRecord::Migration[7.0]
  def up
    rename_column :inventory_items, :price, :price_cents
  end

  def down
    rename_column :inventory_items, :price_cents, :price
  end
end
