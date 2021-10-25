class RemoveInvoiceAndTechIdFromTickets < ActiveRecord::Migration[6.1]
  def change
    remove_index :tickets, name: :index_tickets_on_invoice_id
    remove_index :tickets, name: :index_tickets_on_technician_id

    remove_columns :tickets, :technician_id, :invoice_id
  end
end
