class Invoice < ApplicationRecord
  belongs_to :customer

  has_many :invoice_items, foreign_key: 'invoice_number', primary_key: 'number' 
  has_many :tickets, foreign_key: 'invoice_number', primary_key: 'number'
end
