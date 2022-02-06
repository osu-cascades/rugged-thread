class AddCustomerIdToWorkOrder < ActiveRecord::Migration[6.1]
  def change
    add_reference :work_orders, :customer, null: false, foreign_key: true
  end
end
