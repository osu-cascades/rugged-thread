class RemoveNumberFromInvoice < ActiveRecord::Migration[6.1]
  def change
    remove_column :invoices, :number, :integer
  end
end
