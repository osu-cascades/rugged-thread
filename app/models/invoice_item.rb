class InvoiceItem < ApplicationRecord
  belongs_to :invoice, foreign_key: 'invoice_number', primary_key: 'number', optional: true

  belongs_to :invoice, optional: true

  belongs_to :item_type, optional: true

  has_many :repairs, foreign_key: 'item_number', primary_key: 'number'
end
