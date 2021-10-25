class Ticket < ApplicationRecord
  belongs_to :technician, foreign_key: 'technician_name', primary_key: 'name', optional: true
  belongs_to :invoice, foreign_key: 'invoice_number', primary_key: 'number', optional: true
end
