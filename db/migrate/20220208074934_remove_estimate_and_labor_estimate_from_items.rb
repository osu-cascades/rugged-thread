class RemoveEstimateAndLaborEstimateFromItems < ActiveRecord::Migration[6.1]

  def up
    remove_column :items, :estimate
    remove_column :items, :labor_estimate
  end

  def down
    add_column :items, :estimate, :integer
    add_column :items, :labor_estimate, :integer
  end

end
