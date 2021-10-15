class Repair < ApplicationRecord
  belongs_to :invoice_item, foreign_key: 'item_number', primary_key: 'number', optional: true
  belongs_to :technician, foreign_key: 'technician_name', primary_key: 'name', optional: true

  has_many :tasks, foreign_key: 'repair_number', primary_key: 'number'
end
