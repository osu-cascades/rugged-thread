class CreateItemStatuses < ActiveRecord::Migration[6.1]
  def change
    create_table :item_statuses do |t|
      t.string :name
      t.timestamps
    end
  end
end
