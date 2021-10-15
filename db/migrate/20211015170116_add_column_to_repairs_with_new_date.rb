class AddColumnToRepairsWithNewDate < ActiveRecord::Migration[6.1]
  def change
    add_column :repairs, :date, :string
  end
end
