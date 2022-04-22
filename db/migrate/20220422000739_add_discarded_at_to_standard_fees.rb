class AddDiscardedAtToStandardFees < ActiveRecord::Migration[7.0]
  def change
    add_column :standard_fees, :discarded_at, :datetime
    add_index :standard_fees, :discarded_at
  end
end
