class Customer < ApplicationRecord
  include Discard::Model

  belongs_to :customer_type, counter_cache: true
  has_many :work_orders, dependent: :restrict_with_error
  phony_normalize :phone_number, default_country_code: 'US'
  validates :phone_number, phony_plausible: true
  phony_normalize :alternative_phone_number, default_country_code: 'US'
  validates :alternative_phone_number, phony_plausible: true
  default_scope { order('last_name ASC') }

  def full_name
    "#{first_name} #{last_name}" 
  end

  def to_s
    full_name
  end

end
