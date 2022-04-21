class RenameStandardComplicationPriceToPriceCents < ActiveRecord::Migration[7.0]
  def up
    rename_column :standard_complications, :price, :price_cents
  end

  def down
    rename_column :standard_complications, :price_cents, :price
  end
end
