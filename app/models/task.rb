class Task < ApplicationRecord
  belongs_to :technician, foreign_key: 'technician_name', primary_key: 'name', optional: true
  belongs_to :task_type, foreign_key: 'task_type_name', primary_key: 'name', optional: true
  belongs_to :repair, foreign_key: 'repair_number', primary_key: 'number', optional: true
end
