class Customer < ApplicationRecord
  has_many :work_orders

  def full_name
    "#{first_name} #{last_name}" 
  end

end