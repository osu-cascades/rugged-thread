class ChangeDiscountDollarAmountToPrice < ActiveRecord::Migration[7.0]
  def change
    rename_column :discounts, :dollar_amount, :price
  end
end
