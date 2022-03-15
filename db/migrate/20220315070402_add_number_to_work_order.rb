class AddNumberToWorkOrder < ActiveRecord::Migration[7.0]

  class WorkOrder < ApplicationRecord; end

  def up
    add_column :work_orders, :number, :string, unique: true
    WorkOrder.all.each.with_index { |wo, i| wo.update(number: "MIGRATED-#{i}") }
    change_column_null :work_orders, :number, false
  end

  def down
    remove_column :work_orders, :number
  end

end
