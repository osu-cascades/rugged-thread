class DropTechnicians < ActiveRecord::Migration[7.0]
  def up
    drop_table :technicians
  end

  def down
    create_table "technicians" do |t|
      t.string "name"
      t.string "skill_level"
      t.timestamps
    end
  end
end
