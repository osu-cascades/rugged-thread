class Discount < ApplicationRecord

  belongs_to :standard_discount
  belongs_to :item
  acts_as_list :scope => :item

  validates :percentage_amount, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :dollar_amount, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

end