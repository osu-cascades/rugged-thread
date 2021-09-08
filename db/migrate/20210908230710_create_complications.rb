class CreateComplications < ActiveRecord::Migration[6.1]
  def change
    create_table :complications do |t|
      t.string :time
      t.float :charge
      t.references :repair, null: false, foreign_key: true
      t.references :complication_type, null: false, foreign_key: true

      t.timestamps
    end
  end
end
