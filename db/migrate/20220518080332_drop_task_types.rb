class DropTaskTypes < ActiveRecord::Migration[7.0]
  def up
    drop_table :task_types
  end

  def down
    create_table "task_types" do |t|
      t.string "name"
      t.timestamps
    end
  end
end
