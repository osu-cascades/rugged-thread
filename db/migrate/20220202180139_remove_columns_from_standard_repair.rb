class RemoveColumnsFromStandardRepair < ActiveRecord::Migration[6.1]
  def change
    remove_column :standard_repairs, :sub_repair
    remove_column :standard_repairs, :fee_type
    remove_column :standard_repairs, :complications
  end
end
