class Repair < ApplicationRecord
  belongs_to :invoice_item, foreign_key: 'item_number', primary_key: 'number', optional: true
  belongs_to :repair_type
  belongs_to :technician

  has_many :tasks, foreign_key: 'repair_number', primary_key: 'number'
end
