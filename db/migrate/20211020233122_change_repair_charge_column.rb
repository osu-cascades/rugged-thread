class ChangeRepairChargeColumn < ActiveRecord::Migration[6.1]
  def change
    change_column_null :repairs, :charge, true
  end
end
