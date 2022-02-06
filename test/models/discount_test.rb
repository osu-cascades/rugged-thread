require "test_helper"

class DiscountTest < ActiveSupport::TestCase

  test 'attributes' do
    assert_respond_to(Discount.new, :name)
    assert_respond_to(Discount.new, :percentage_amount)
    assert_respond_to(Discount.new, :dollar_amount)
  end

  test 'must have a name' do
    discount = discounts(:one)
    assert discount.valid?
    discount.name = nil
    refute discount.valid?
  end

  test 'name must be unique' do
    existing_discount_name = discounts(:one).name
    discount = discounts(:two)
    assert discount.valid?
    discount.name = existing_discount_name
    refute discount.valid?
  end

  test '#to_s string representation is name' do
    name = 'FAKE'
    assert_equal(name, Discount.new(name: name).to_s)
  end

end
