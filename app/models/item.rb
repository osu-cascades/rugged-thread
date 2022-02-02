class Item < ApplicationRecord
  belongs_to :brand
  belongs_to :item_status
  belongs_to :item_type
  belongs_to :work_order
  has_many :items, dependent: :restrict_with_error
end
