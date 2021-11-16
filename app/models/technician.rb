class Technician < ApplicationRecord
  after_initialize :init

  has_many :tasks, foreign_key: 'technician_name', primary_key: 'name'
  has_many :tickets, foreign_key: 'technician_name', primary_key: 'name'

  def init
    self.status = true if self.status.nil?
  end

end
