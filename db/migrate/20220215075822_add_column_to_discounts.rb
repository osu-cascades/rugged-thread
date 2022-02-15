class AddColumnToDiscounts < ActiveRecord::Migration[7.0]
  def change
    add_column :discounts, :dollar_amount, :integer
    add_column :discounts, :percentage_amount, :integer
  end
end
