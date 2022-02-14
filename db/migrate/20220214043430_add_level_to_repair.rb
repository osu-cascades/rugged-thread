class AddLevelToRepair < ActiveRecord::Migration[7.0]
  def change
    add_column :repairs, :level, :integer, null: false, default: 1
  end
end
