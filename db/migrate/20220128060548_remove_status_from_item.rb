class RemoveStatusFromItem < ActiveRecord::Migration[6.1]
  def change
    remove_column :items, :status
  end
end
