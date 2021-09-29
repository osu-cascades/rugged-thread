class AddDetailsToRepairs < ActiveRecord::Migration[6.1]
  def change
    add_column :repairs, :date, :date
    add_column :repairs, :time, :integer
  end
end
