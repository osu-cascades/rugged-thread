class RenameStandardDiscountPriceToPriceCents < ActiveRecord::Migration[7.0]
  def up
    rename_column :standard_discounts, :price, :price_cents
  end

  def down
    rename_column :standard_discounts, :price_cents, :price
  end
end
