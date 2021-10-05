class AddInvoiceNumberToInvoiceItems < ActiveRecord::Migration[6.1]
  def change
    add_column :invoice_items, :invoice_number, :integer
  end
end
