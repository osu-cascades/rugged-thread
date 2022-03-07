class WorkOrder < ApplicationRecord

  belongs_to :creator, class_name: 'User', inverse_of: :created_work_orders
  belongs_to :customer
  has_many :items, dependent: :restrict_with_error

  validates :in_date, presence: true, comparison: { less_than: :due_date }
  validates :due_date, presence: true, comparison: { greater_than: :in_date }

  default_scope { order('created_at ASC') }

  def to_s
    "Work Order #{id}"
  end

  def estimate
    items.reduce(0) { |sum, i| sum + i.estimate }
  end

end
