class RemoveFkInvoiceItems < ActiveRecord::Migration[6.1]
  def change
    remove_foreign_key :invoice_items, :item_types
  end
end
