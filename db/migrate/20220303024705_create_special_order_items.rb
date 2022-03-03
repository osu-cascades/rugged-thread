class CreateSpecialOrderItems < ActiveRecord::Migration[7.0]
  def change
    create_table :special_order_items do |t|
      t.string :name
      t.integer :price
      t.references :repair, null: false, foreign_key: true

      t.timestamps
    end
  end
end
