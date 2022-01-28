class Customer < ApplicationRecord

  has_many :work_orders, dependent: :restrict_with_error

  def full_name
    "#{first_name} #{last_name}" 
  end

  def to_s
    full_name
  end

end
