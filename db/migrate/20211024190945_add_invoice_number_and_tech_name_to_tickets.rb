class AddInvoiceNumberAndTechNameToTickets < ActiveRecord::Migration[6.1]
  def change
    add_column :tickets, :invoice_number, :integer
    add_column :tickets, :technician_name, :string
  end
end
