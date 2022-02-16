class CreateComplications < ActiveRecord::Migration[7.0]
  def change
    create_table :complications do |t|
      t.references :standard_complication, null: false, foreign_key: true
      t.references :repair, null: false, foreign_key: true
      t.integer :price, null: false, default: 0

      t.timestamps
    end
  end
end
