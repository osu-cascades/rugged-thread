class RenameDiscountDescriptionToName < ActiveRecord::Migration[6.1]

  def up
    rename_column :discounts, :description, :name
  end

  def down
    rename_column :discounts, :name, :description
  end

end
