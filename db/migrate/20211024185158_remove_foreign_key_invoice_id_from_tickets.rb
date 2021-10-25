class RemoveForeignKeyInvoiceIdFromTickets < ActiveRecord::Migration[6.1]
  def change
    remove_foreign_key :tickets, column: :invoice_id
  end
end
