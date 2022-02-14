class Discount < ApplicationRecord

  belongs_to :standard_discount
  belongs_to :item
  
end