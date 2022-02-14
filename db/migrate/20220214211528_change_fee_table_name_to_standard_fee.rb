class ChangeFeeTableNameToStandardFee < ActiveRecord::Migration[7.0]
  def change
    rename_table :fees, :standard_fees
  end
end
