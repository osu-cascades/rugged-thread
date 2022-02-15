class RemoveComplicationTypes < ActiveRecord::Migration[7.0]
  def up
    drop_table :complication_types
  end

  def down
    create_table :complication_types do |t|
      t.string :description

      t.timestamps
    end
  end
end
