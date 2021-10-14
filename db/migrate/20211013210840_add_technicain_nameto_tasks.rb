class AddTechnicainNametoTasks < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :technician_name, :string
  end
end
