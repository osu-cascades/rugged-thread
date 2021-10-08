class Task < ApplicationRecord
  belongs_to :technician, optional: true

  belongs_to :repair, foreign_key: 'repair_number', primary_key: 'number', optional: true
end
