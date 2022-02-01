class AddCreatorToWorkOrder < ActiveRecord::Migration[6.1]

  class User < ApplicationRecord; end

  class WorkOrder < ApplicationRecord
    belongs_to :creator, class_name: 'User'
  end

  def up
    migration_user = User.first
    add_reference :work_orders, :creator
    WorkOrder.all.each do |work_order|
      work_order.creator = migration_user
      work_order.save!
    end
    change_column_null :work_orders, :creator_id, false
    add_foreign_key :work_orders, :users, column: :creator_id
  end

  def down
    remove_column :work_orders, :creator_id
  end

end
