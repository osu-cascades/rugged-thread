class AddForeignKeyInvoiceNumberToTickets < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :tickets, :invoices, column: :invoice_number, primary_key: :number
  end
end
