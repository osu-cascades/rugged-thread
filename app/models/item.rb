class Item < ApplicationRecord
  belongs_to :brand
  belongs_to :work_order
  belongs_to :item_type

  belongs_to :item_status
end
