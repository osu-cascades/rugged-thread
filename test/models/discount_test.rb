require "test_helper"

class DiscountTest < ActiveSupport::TestCase

  test "associations" do
    assert_respond_to(Discount.new, :item)
    assert_respond_to(Discount.new, :standard_discount)
  end

  test "attributes" do
    assert_respond_to(Discount.new, :percentage_amount)
    assert_respond_to(Discount.new, :price)
  end

  test "must have a standard discount" do
    discount = discounts(:one)
    assert discount.valid?
    discount.standard_discount = nil
    refute discount.valid?
  end

  test "must have an item" do
    discount = discounts(:one)
    assert discount.valid?
    discount.item = nil
    refute discount.valid?
  end

  test 'percentage_amount must be a positive integer' do
    discount = discounts(:percentage)
    assert discount.valid?
    discount.percentage_amount = -1
    refute discount.valid?
  end

  test 'price must be a positive integer' do
    discount = discounts(:price)
    assert discount.valid?
    discount.price = -1
    refute discount.valid?
  end

  test 'is invalid when both percentage and price are not present' do
    discount = discounts(:price)
    assert discount.valid?
    discount.price = nil
    discount.percentage_amount = 10
    assert discount.valid?
    discount.percentage_amount = nil
    refute discount.valid?
  end

  test 'is invalid when both percentage and price are present' do
    discount = discounts(:price)
    assert discount.valid?
    discount.percentage_amount = 10
    refute discount.valid?
  end

  test '#name is the standard discount name' do
    discount = discounts(:one)
    assert_equal discount.standard_discount.name, discount.name
  end

  test '#to_s string representation is name' do
    discount = discounts(:one)
    assert_equal discount.name, discount.to_s
  end

end
