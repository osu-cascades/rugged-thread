class CreateInvoiceItems < ActiveRecord::Migration[6.1]
  def change
    create_table :invoice_items do |t|
      t.text :description
      t.references :invoice, null: false, foreign_key: true

      t.timestamps
    end
  end
end
