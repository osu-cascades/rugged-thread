class Complication < ApplicationRecord
  belongs_to :repair
  belongs_to :complication_type
end
