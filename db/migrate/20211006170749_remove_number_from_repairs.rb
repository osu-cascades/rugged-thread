class RemoveNumberFromRepairs < ActiveRecord::Migration[6.1]
  def change
    remove_column :repairs, :number, :integer
  end
end
