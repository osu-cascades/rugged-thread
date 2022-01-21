class DropAmountFromDiscount < ActiveRecord::Migration[6.1]
  def change
    remove_column :discounts, :amount
  end
end
