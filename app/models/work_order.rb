class WorkOrder < ApplicationRecord
    belongs_to :user
    belongs_to :customer

    accepts_nested_attributes_for :customer
    accepts_nested_attributes_for :user
end
