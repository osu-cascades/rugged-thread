class DropInvoiceItemsRepairs < ActiveRecord::Migration[7.0]
  def up
    drop_table :invoice_items_repairs
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
