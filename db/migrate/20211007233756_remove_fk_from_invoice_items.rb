class RemoveFkFromInvoiceItems < ActiveRecord::Migration[6.1]
  def change
    remove_column :invoice_items, :item_type_id
  end
end
