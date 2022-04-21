class AddDiscardColumnToCustomerTypes < ActiveRecord::Migration[7.0]
  def change
    add_column :customer_types, :discarded_at, :datetime
    add_index :customer_types, :discarded_at
  end
end
