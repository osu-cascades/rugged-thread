class RemoveEstimateFromWorkOrder < ActiveRecord::Migration[6.1]

  def up
    remove_column :work_orders, :estimate
  end

  def down
    add_column :work_orders, :estimate, :integer
  end

end
