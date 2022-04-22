class AddDiscardedAtToStandardRepairs < ActiveRecord::Migration[7.0]
  def change
    add_column :standard_repairs, :discarded_at, :datetime
    add_index :standard_repairs, :discarded_at
  end
end
