class AddAmountColumnsToDiscount < ActiveRecord::Migration[6.1]
  def change
    add_column :discounts, :percentage_amount, :integer
    add_column :discounts, :dollar_amount, :integer
  end
end
