class ChangeDiscountNullConstraint < ActiveRecord::Migration[7.0]
  def change
    change_column_null :discounts, :dollar_amount, true
    change_column_null :discounts, :percentage_amount, true
  end
end
