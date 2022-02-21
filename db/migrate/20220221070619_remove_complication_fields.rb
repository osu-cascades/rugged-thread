class RemoveComplicationFields < ActiveRecord::Migration[7.0]
  def change
    remove_column :standard_complications, :method
    remove_column :standard_complications, :description
    remove_column :standard_complications, :level
  end
end
