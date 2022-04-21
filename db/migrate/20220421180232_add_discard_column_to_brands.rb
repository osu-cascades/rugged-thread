class AddDiscardColumnToBrands < ActiveRecord::Migration[7.0]
  def change
    add_column :brands, :discarded_at, :datetime
    add_index :brands, :discarded_at
  end
end
