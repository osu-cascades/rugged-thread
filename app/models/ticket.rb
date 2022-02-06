class Ticket < ApplicationRecord
  belongs_to :technician
  belongs_to :invoice
end
