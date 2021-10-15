class AddTechnicainNametoRepairs < ActiveRecord::Migration[6.1]
  def change
    add_column :repairs, :technician_name, :string
  end
end
