class RenameSpecialOrderItemPriceToPriceCents < ActiveRecord::Migration[7.0]
  def up
    rename_column :special_order_items, :price, :price_cents
    rename_column :special_order_items, :ordering_fee_price, :ordering_fee_price_cents
    rename_column :special_order_items, :freight_fee_price, :freight_fee_price_cents
  end

  def down
    rename_column :special_order_items, :price_cents, :price
    rename_column :special_order_items, :ordering_fee_price_cents, :ordering_fee_price
    rename_column :special_order_items, :freight_fee_price_cents, :freight_fee_price
  end
end
