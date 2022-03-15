class AddFeesToSpecialOrderItems < ActiveRecord::Migration[7.0]
  def change
    add_column :special_order_items, :ordering_fee_price, :integer, default: 0, null: false
    add_column :special_order_items, :freight_fee_price, :integer, default: 0, null: false
  end
end
