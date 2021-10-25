class RemoveForeignKeyTechnicianIdFromTickets < ActiveRecord::Migration[6.1]
  def change
    remove_foreign_key :tickets, column: :technician_id
  end
end
