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

  test 'Discount without a Percentage non-integer value is invalid' do
    discount = discounts(:one)
    assert discount.valid?
    discount.percentage_amount = "FakeDiscountPercentage"
    refute discount.valid?
  end

  test 'Discount without a Dollar non-integer value is invalid' do
    discount = discounts(:one)
    assert discount.valid?
    discount.dollar_amount = "FakeDiscountDollar"
    refute discount.valid?
  end

  test 'Discount without a Percentage float value is invalid' do
    discount = discounts(:one)
    assert discount.valid?
    discount.percentage_amount = 1.5
    refute discount.valid?
  end

  test 'Discount without a Dollar float value is invalid' do
    discount = discounts(:one)
    assert discount.valid?
    discount.dollar_amount = 1.5
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
