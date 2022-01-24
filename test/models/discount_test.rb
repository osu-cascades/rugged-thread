require "test_helper"

class DiscountTest < ActiveSupport::TestCase
  test 'Discount has a description' do
    assert_respond_to(Discount.new, :description)
  end


  test 'Discount without a description is invalid' do
    discount = discounts(:one)
    assert discount.valid?
    discount.description = nil
    refute discount.valid?
  end


  test 'Discount with a non-unique description is invalid' do
    existing_discount_description = discounts(:one).description
    discount = discounts(:two)
    assert discount.valid?
    discount.description = existing_discount_description
    refute discount.valid?
  end
end
