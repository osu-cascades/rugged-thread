class RenameComplicationPriceToPriceCents < ActiveRecord::Migration[7.0]

  def up
    rename_column :complications, :price, :price_cents
  end

  def down
    rename_column :complications, :price_cents, :price
  end

end
