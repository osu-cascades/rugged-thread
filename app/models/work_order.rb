class WorkOrder < ApplicationRecord

  belongs_to :creator, class_name: 'User', inverse_of: :created_work_orders
  belongs_to :customer
  has_many :items, dependent: :restrict_with_error

  validates :in_date, presence: true
  validates :due_date, presence: true, comparison: { greater_than: :in_date }

  after_initialize :set_in_date, if: -> { new_record? && in_date.blank? }
  after_initialize :set_due_date, if: -> { new_record? && due_date.blank? }

  default_scope { order('created_at ASC') }

  def to_s
    "Work Order #{id}"
  end

  def estimate
    items.reduce(0) { |sum, i| sum + i.estimate }
  end

  private

  def set_due_date
    self.due_date = default_due_date
  end

  def set_in_date
    self.in_date = default_in_date
  end

  def default_in_date
    Date.current
  end

  def default_due_date
    base_due_date + default_turn_around_days
  end

  def base_due_date
    self.in_date || Date.current
  end

  def default_turn_around_days
    customer&.customer_type&.turn_around&.days || 0.days
  end

end
