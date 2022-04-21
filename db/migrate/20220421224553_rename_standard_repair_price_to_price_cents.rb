class RenameStandardRepairPriceToPriceCents < ActiveRecord::Migration[7.0]
  def up
    rename_column :standard_repairs, :price, :price_cents
  end

  def down
    rename_column :standard_repairs, :price_cents, :price
  end
end
