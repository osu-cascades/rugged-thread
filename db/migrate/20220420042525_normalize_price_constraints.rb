class NormalizePriceConstraints < ActiveRecord::Migration[7.0]

  def up
    change_column_null :fees, :price, false
    change_column_default :inventory_items, :price, 0
    change_column_null :inventory_items, :price, false
    change_column_null :repairs, :price, false
    change_column_default :standard_fees, :price, 0
    change_column_null :standard_fees, :price, false
    change_column_default :standard_inventory_items, :price, 0
    change_column_null :standard_inventory_items, :price, false
    change_column_default :standard_repairs, :price, 0
    change_column_null :standard_repairs, :price, false
  end

  def down
    change_column_null :fees, :price, true
    remove_column_default :inventory_items, :price, nil
    change_column_null :inventory_items, :price, true
    change_column_null :repairs, :price, true
    remove_column_default :standard_fees, :price, nil
    change_column_null :standard_fees, :price, true
    remove_column_default :standard_inventory_items, :price, nil
    change_column_null :standard_inventory_items, :price, true
    remove_column_default :standard_repairs, :price, nil
    change_column_null :standard_repairs, :price, true
  end

end
