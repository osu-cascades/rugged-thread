class RenameQuoteRequestWillMailItemToShippingAsBoolean < ActiveRecord::Migration[7.0]

  def up
    remove_column :quote_requests, :will_mail_item
    add_column :quote_requests, :shipping, :boolean
  end

  def down
    remove_column :quote_requests, :shipping
    add_column :quote_requests, :will_mail_item, :string
  end
end
