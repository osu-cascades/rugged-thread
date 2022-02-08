class ChangeRepairPriceDefaultValue < ActiveRecord::Migration[6.1]
  def change
    change_column :repairs, :price, :integer, :default => 0
  end
end
