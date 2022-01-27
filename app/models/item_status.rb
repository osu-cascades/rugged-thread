class ItemStatus < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: true

  has_many :items
end
