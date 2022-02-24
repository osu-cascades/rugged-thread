class Fee < ApplicationRecord

  belongs_to :standard_fee
  belongs_to :item
  acts_as_list :scope => :item

  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

end