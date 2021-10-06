class AddFkNumberToRepairs < ActiveRecord::Migration[6.1]
  def change
    add_column :repairs, :number, :string
  end
end
