class AddDiscardedAtToShopParameters < ActiveRecord::Migration[7.0]
  def change
    add_column :shop_parameters, :discarded_at, :datetime
    add_index :shop_parameters, :discarded_at
  end
end
