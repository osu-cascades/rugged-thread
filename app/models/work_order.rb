class WorkOrder < ApplicationRecord

  belongs_to :customer
  has_many :items, dependent: :restrict_with_error

  default_scope { order('created_at ASC') }

  def to_s
    "Work Order #{id}"
  end

end
