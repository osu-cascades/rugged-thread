require "test_helper"

class StandardDiscountTest < ActiveSupport::TestCase

  test 'attributes' do
    assert_respond_to(StandardDiscount.new, :name)
    assert_respond_to(StandardDiscount.new, :percentage_amount)
    assert_respond_to(StandardDiscount.new, :price)
    assert_respond_to(StandardDiscount.new, :price_cents)
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
    standard_discount.percentage_amount = 0
    refute standard_discount.valid?
  end

  test "price is a value object" do
    assert_equal Money.from_cents(100), StandardDiscount.new(price: 1).price
    assert_equal Money.from_cents(200), StandardDiscount.new(price: '2').price
    assert_equal Money.from_cents(300), StandardDiscount.new(price: '3.00').price
  end

  test 'price must be a positive integer' do
    standard_discount = standard_discounts(:one)
    assert standard_discount.valid?
    standard_discount.price = -1
    refute standard_discount.valid?
    standard_discount.price = 0
    refute standard_discount.valid?
  end

  test 'is invalid when both percentage and price are not present' do
    standard_discount = standard_discounts(:price)
    assert standard_discount.valid?
    standard_discount.price = nil
    standard_discount.percentage_amount = 10
    assert standard_discount.valid?
    standard_discount.percentage_amount = nil
    refute standard_discount.valid?
  end

  test 'is invalid when both percentage and price are present' do
    standard_discount = standard_discounts(:price)
    assert standard_discount.valid?
    standard_discount.percentage_amount = 10
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
