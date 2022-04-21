class RenameDiscountPriceToPriceCents < ActiveRecord::Migration[7.0]
  def up
    rename_column :discounts, :price, :price_cents
  end

  def down
    rename_column :discounts, :price_cents, :price
  end
end
