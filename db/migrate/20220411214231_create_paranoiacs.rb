class CreateParanoiacs < ActiveRecord::Migration[7.0]
  def change
    create_table :paranoiacs do |t|

      t.timestamps
    end
  end
end
