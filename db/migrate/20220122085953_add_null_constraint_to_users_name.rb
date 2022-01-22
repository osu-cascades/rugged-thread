class AddNullConstraintToUsersName < ActiveRecord::Migration[6.1]
  def up
    update "UPDATE users SET name = 'FIXME' WHERE name IS NULL;"
    change_column_null :users, :name, false
  end

  def down
    change_column_null :users, :name, true
  end
end
