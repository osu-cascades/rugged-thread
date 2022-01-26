class WorkOrder < ApplicationRecord
  belongs_to :customer
  has_many :items
end
