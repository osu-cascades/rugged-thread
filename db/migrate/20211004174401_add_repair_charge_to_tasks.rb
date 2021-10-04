class AddRepairChargeToTasks < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :repair_charge, :float
  end
end
