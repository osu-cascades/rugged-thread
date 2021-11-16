class TaskType < ApplicationRecord
  after_initialize :init
  
  has_many :tasks, foreign_key: 'task_type_name', primary_key: 'name'

  def init
    self.status = true if self.status.nil?
  end

end
