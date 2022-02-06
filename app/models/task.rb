class Task < ApplicationRecord
  belongs_to :task_type
  belongs_to :technician
end
