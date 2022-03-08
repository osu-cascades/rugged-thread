class ChangeStandardComplicationChargeToPrice < ActiveRecord::Migration[7.0]
  def change
    rename_column :standard_complications, :charge, :price
  end
end
