class AddCustomerTypeToCustomer < ActiveRecord::Migration[6.1]

  class CustomerType < ApplicationRecord; end

  class Customer < ApplicationRecord
    belongs_to :customer_type
  end

  def up
    migration_customer_type = CustomerType.create!(name: 'Migration')
    add_reference :customers, :customer_type
    Customer.all.each do |customer|
      customer.customer_type = migration_customer_type
      customer.save!
    end
    change_column_null :customers, :customer_type_id, false
    add_foreign_key :customers, :customer_types
  end

  def down
    remove_column :customers, :customer_type_id
    CustomerType.find_by_name('Migration').destroy!
  end

end
