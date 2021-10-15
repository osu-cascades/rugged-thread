class AddTechnicianForeignKeyToRepairs < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :repairs, :technicians, column: :technician_name, primary_key: :name
  end
end
