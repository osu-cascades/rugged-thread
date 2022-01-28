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

  test '#to_s string representation is description and amounts' do
    description = 'FAKE'
    dollar_amount = 1
    percentage_amount = 2
    expected = "#{description} $#{dollar_amount} / #{percentage_amount}%"
    discount = Discount.new(description: description, dollar_amount: dollar_amount,
     percentage_amount: percentage_amount)
    assert_equal expected, discount.to_s
  end

end
