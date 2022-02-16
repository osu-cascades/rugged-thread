class Fee < ApplicationRecord

  belongs_to :standard_fee
  belongs_to :item

end