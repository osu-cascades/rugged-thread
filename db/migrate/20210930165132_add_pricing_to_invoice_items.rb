class AddPricingToInvoiceItems < ActiveRecord::Migration[6.1]
  def change
    add_column :invoice_items, :quote, :float
    add_column :invoice_items, :charge, :float
  end
end
