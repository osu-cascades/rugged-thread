class AddNotesToRepairs < ActiveRecord::Migration[6.1]
  def change
    add_column :repairs, :notes, :text
  end
end
