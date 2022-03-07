class AddDueDateToWorkOrder < ActiveRecord::Migration[7.0]

  class WorkOrder < ApplicationRecord
    belongs_to :customer
  end

  def up
    add_column :work_orders, :due_date, :date
    WorkOrder.all.each do |wo|
      wo.update(due_date: wo.in_date + wo.customer.customer_type.turn_around.days)
    end
    change_column_null :work_orders, :due_date, false
  end

  def down
    remove_column :work_orders, :due_date, :date
  end
end
