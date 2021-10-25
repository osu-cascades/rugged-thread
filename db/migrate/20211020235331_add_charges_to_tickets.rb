class AddChargesToTickets < ActiveRecord::Migration[6.1]
  def change
    add_column :tickets, :labor_charge, :integer
    add_column :tickets, :material_charge, :integer
  end
end
