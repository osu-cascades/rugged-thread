class AddDiscardedAtToStandardComplications < ActiveRecord::Migration[7.0]
  def change
    add_column :standard_complications, :discarded_at, :datetime
    add_index :standard_complications, :discarded_at
  end
end
