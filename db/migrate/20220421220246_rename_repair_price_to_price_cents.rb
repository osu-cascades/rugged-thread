class RenameRepairPriceToPriceCents < ActiveRecord::Migration[7.0]
  def up
    rename_column :repairs, :price, :price_cents
  end

  def down
    rename_column :repairs, :price_cents, :price
  end
end
