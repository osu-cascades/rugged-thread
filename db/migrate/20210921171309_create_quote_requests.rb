class CreateQuoteRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :quote_requests do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone_number
      t.string :item_type
      t.string :brand
      t.string :will_mail_item
      t.string :promo_code
      t.text :description

      t.timestamps
    end
  end
end
