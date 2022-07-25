class AddQCustomerTypeIdToCustomerTypes < ActiveRecord::Migration[7.0]
  def change
    add_column :customer_types, :q_customer_type_id, :string
  end
end
