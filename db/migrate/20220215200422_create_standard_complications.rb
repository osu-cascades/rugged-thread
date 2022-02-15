class CreateStandardComplications < ActiveRecord::Migration[7.0]
  def change
    create_table :standard_complications do |t|
      t.string :name
      t.string :method
      t.text :description
      t.integer :charge, default: 0, null: false
      t.integer :level, default: 1, null: false
      t.references :standard_repair, null: false, foreign_key: true

      t.timestamps
    end
  end
end
