class Invoice < ApplicationRecord
  belongs_to :customer

  has_many :invoice_items, foreign_key: 'invoice_number', primary_key: 'number' 
end
