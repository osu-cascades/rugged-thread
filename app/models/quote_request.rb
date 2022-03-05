class QuoteRequest < ApplicationRecord

  enum :status, [:fresh, :todo], default: :fresh

  belongs_to :item_type
  belongs_to :brand

  has_many_attached :photos

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :phone_number, presence: true
  validates :description, presence: true
  validates :shipping, inclusion: { in: [ true, false ] }
  validates :status, presence: true

end
