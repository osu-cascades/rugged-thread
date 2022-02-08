class Item < ApplicationRecord

  belongs_to :brand
  belongs_to :item_status
  belongs_to :item_type
  belongs_to :work_order
  has_many :repairs, dependent: :restrict_with_error

  after_initialize :set_default_status

  def estimate
    'TODO'
  end

  def labor_estimate
    'TODO'
  end

  private

  def set_default_status
    self.item_status = ItemStatus.default
  end

end
