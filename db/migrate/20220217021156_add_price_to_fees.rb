class AddPriceToFees < ActiveRecord::Migration[7.0]
  def change
    add_column :fees, :price, :integer, :default => 0
  end
end
