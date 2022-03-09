class ChangeStandardRepairChargeToPrice < ActiveRecord::Migration[7.0]
  def change
    rename_column :standard_repairs, :charge, :price
  end
end
