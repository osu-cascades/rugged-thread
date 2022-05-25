class AddCountryToCustomerAddresses < ActiveRecord::Migration[7.0]
  def change
    add_column :customers, :shipping_country, :string, null: true
    add_column :customers, :billing_country, :string, null: true
  end
end
