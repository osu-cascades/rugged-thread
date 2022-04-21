class RenameStandardFeePriceToPriceCents < ActiveRecord::Migration[7.0]
  def up
    rename_column :standard_fees, :price, :price_cents
  end

  def down
    rename_column :standard_fees, :price_cents, :price
  end
end
