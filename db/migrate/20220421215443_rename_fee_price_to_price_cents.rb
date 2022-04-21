class RenameFeePriceToPriceCents < ActiveRecord::Migration[7.0]
  def up
    rename_column :fees, :price, :price_cents
  end

  def down
    rename_column :fees, :price_cents, :price
  end
end
