class ItemType < ApplicationRecord
  validates :name, presence: true, uniqueness: true
end
