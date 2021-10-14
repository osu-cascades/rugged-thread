class RemoveEstimateFloatFromInvoices < ActiveRecord::Migration[6.1]
  def change
    remove_column :invoices, :invoice_estimate
  end
end
