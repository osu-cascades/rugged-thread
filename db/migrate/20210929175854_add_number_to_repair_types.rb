class AddNumberToRepairTypes < ActiveRecord::Migration[6.1]
  def change
    add_column :repair_types, :number, :string
  end
end
