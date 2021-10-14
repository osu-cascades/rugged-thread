class Technician < ApplicationRecord
  has_many :tasks, foreign_key: 'technician_name', primary_key: 'name'
end
