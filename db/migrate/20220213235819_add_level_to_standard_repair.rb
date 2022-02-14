class AddLevelToStandardRepair < ActiveRecord::Migration[7.0]
  def change
    add_column :standard_repairs, :level, :integer, null: false, default: 1
  end
end
