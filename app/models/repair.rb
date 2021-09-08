class Repair < ApplicationRecord
  belongs_to :invoice_item
  belongs_to :repair_type
  belongs_to :technician
end
