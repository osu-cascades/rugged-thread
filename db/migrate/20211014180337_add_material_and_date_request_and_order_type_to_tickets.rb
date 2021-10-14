class AddMaterialAndDateRequestAndOrderTypeToTickets < ActiveRecord::Migration[6.1]
  def change
    add_column :tickets, :material, :text
    add_column :tickets, :request_date, :string
    add_column :tickets, :order_type, :string
  end
end
