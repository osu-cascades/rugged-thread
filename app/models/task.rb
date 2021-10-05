class Task < ApplicationRecord
  belongs_to :task_type
  belongs_to :technician

  belongs_to :repair, foreign_key: 'repair_number', primary_key: 'number', optional: true
end
