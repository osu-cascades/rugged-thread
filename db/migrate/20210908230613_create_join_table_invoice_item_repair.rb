class CreateJoinTableInvoiceItemRepair < ActiveRecord::Migration[6.1]
  def change
    create_join_table :invoice_items, :repairs do |t|
      # t.index [:invoice_item_id, :repair_id]
      # t.index [:repair_id, :invoice_item_id]
    end
  end
end
