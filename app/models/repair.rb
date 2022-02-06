class Repair < ApplicationRecord
  belongs_to :standard_repair
  belongs_to :item
end
