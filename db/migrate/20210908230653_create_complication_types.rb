class CreateComplicationTypes < ActiveRecord::Migration[6.1]
  def change
    create_table :complication_types do |t|
      t.string :description

      t.timestamps
    end
  end
end
