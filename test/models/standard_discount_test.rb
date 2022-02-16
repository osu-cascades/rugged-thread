require "test_helper"

class StandardDiscountTest < ActiveSupport::TestCase

  test 'attributes' do
    assert_respond_to(StandardDiscount.new, :name)
    assert_respond_to(StandardDiscount.new, :percentage_amount)
    assert_respond_to(StandardDiscount.new, :dollar_amount)
  end

  test "associations" do
    assert_respond_to(StandardDiscount.new, :discounts)
  end

  test 'cannot be deleted if it has associated discounts' do
    standard_discount = standard_discounts(:one)
    assert_not_empty standard_discount.discounts
    standard_discount.destroy
    refute standard_discount.destroyed?
  end

  test 'must have a name' do
    standard_discount = standard_discounts(:one)
    assert standard_discount.valid?
    standard_discount.name = nil
    refute standard_discount.valid?
  end

  test 'percentage_amount must be a positive integer' do
    standard_discount = standard_discounts(:one)
    assert standard_discount.valid?
    standard_discount.percentage_amount = -1
    refute standard_discount.valid?
  end

  test 'dollar_amount must be a positive integer' do
    standard_discount = standard_discounts(:one)
    assert standard_discount.valid?
    standard_discount.dollar_amount = -1
    refute standard_discount.valid?
  end

  test 'name must be unique' do
    existing_standard_discount_name = standard_discounts(:one).name
    standard_discount = standard_discounts(:two)
    assert standard_discount.valid?
    standard_discount.name = existing_standard_discount_name
    refute standard_discount.valid?
  end

  test '#to_s string representation is name' do
    name = 'FAKE'
    assert_equal(name, StandardDiscount.new(name: name).to_s)
  end

end
