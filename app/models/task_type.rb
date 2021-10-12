class TaskType < ApplicationRecord
  has_many :tasks, foreign_key: 'task_type_name', primary_key: 'name'
end
