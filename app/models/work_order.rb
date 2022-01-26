class WorkOrder < ApplicationRecord
  belongs_to :customer
  has_many :items, dependent: :restrict_with_error
end
