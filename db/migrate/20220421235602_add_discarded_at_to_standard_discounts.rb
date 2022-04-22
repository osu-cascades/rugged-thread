class AddDiscardedAtToStandardDiscounts < ActiveRecord::Migration[7.0]
  def change
    add_column :standard_discounts, :discarded_at, :datetime
    add_index :standard_discounts, :discarded_at
  end
end
