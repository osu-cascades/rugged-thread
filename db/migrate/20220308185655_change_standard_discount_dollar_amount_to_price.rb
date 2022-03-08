class ChangeStandardDiscountDollarAmountToPrice < ActiveRecord::Migration[7.0]
  def change
    rename_column :standard_discounts, :dollar_amount, :price
  end
end
