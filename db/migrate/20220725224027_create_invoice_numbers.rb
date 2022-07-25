class CreateInvoiceNumbers < ActiveRecord::Migration[7.0]
  def change
    create_table :invoice_numbers do |t|
      t.integer :number
      t.integer :month
      t.integer :year

      t.timestamps
    end
  end
end
