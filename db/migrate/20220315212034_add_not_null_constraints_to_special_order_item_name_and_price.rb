class AddNotNullConstraintsToSpecialOrderItemNameAndPrice < ActiveRecord::Migration[7.0]
  def up
    change_column_null :special_order_items, :name, false
    change_column_default :special_order_items, :price, 0
    change_column_null :special_order_items, :price, false
  end

  def down
    change_column_null :special_order_items, :name, true
    change_column_null :special_order_items, :price, true
    change_column_default :special_order_items, :price, nil
  end
end
