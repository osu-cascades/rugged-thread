class Discount < ApplicationRecord

  acts_as_list scope: :item

  belongs_to :standard_discount
  belongs_to :item

  # removed to allow submission of only one or the other
  # validates :percentage_amount, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  # validates :dollar_amount, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  default_scope { order('position ASC') }

  def name
    standard_discount&.name
  end

  def to_s
    name
  end

end
