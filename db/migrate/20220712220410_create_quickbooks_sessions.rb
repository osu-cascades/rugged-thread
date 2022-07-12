class CreateQuickbooksSessions < ActiveRecord::Migration[7.0]
  def change
    create_table :quickbooks_sessions do |t|
      t.text :access_token
      t.text :realm_id
      t.text :refresh_token

      t.timestamps
    end
  end
end
