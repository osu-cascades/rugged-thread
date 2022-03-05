class AddStatusToQuoteRequests < ActiveRecord::Migration[7.0]
  def change
    add_column :quote_requests, :status, :integer, default: 0, null: false
  end
end
