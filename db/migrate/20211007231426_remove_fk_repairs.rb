class RemoveFkRepairs < ActiveRecord::Migration[6.1]
  def change
    remove_foreign_key :repairs, :repair_types
  end
end
