class ChangeDiscountTableNameToStandardDiscount < ActiveRecord::Migration[7.0]
  def change
    rename_table :discounts, :standard_discounts
  end
end
