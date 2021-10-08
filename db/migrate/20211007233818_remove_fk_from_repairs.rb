class RemoveFkFromRepairs < ActiveRecord::Migration[6.1]
  def change
    remove_foreign_key :repairs, column: :repair_type_id
  end
end
