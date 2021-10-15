class ChangeRepairDateInRepairs < ActiveRecord::Migration[6.1]
  def change
    remove_column :repairs, :date
  end
end
