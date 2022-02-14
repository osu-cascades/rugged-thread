class CreateDiscount < ActiveRecord::Migration[7.0]
  def change
    create_table :discounts do |t|
      t.references :standard_discount, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true
      t.timestamps
    end
  end
end
