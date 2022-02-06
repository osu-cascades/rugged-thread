class AddNumberToInvoiceItems < ActiveRecord::Migration[6.1]
  def change
    add_column :invoice_items, :number, :integer
  end
end
