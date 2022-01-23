class CreateWorkOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :work_orders do |t|
      t.date :in_date
      t.bigint :estimate
      t.boolean :shipping

      t.timestamps
    end
  end
end
