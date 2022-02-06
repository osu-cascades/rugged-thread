class RenameFeeDescriptionToName < ActiveRecord::Migration[6.1]

  def up
    rename_column :fees, :description, :name
  end

  def down
    rename_column :fees, :name, :description
  end

end
