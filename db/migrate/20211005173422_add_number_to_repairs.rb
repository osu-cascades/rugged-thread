class AddNumberToRepairs < ActiveRecord::Migration[6.1]
  def change
    add_column :repairs, :number, :integer
  end
end
