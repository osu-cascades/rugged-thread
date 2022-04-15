class AddDiscardToCustomers < ActiveRecord::Migration[7.0]
  def change
    add_column :customers, :discarded_at, :datetime
    add_index :customers, :discarded_at
  end
end
