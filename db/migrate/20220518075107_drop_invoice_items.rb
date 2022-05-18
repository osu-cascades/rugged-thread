class DropInvoiceItems < ActiveRecord::Migration[7.0]
  def up
    drop_table :invoice_items
  end

  def down
    create_table "invoice_items" do |t|
      t.text "description"
      t.references "invoice", null: false, foreign_key: true
      t.timestamps
      t.integer "number"
      t.float "quote"
      t.float "charge"
    end
  end
end
