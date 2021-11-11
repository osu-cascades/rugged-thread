class AddStatusTechnicianToTechnician < ActiveRecord::Migration[6.1]
  def change
    add_column :technicians, :status, :boolean
  end
end
