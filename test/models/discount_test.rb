require "test_helper"

class DiscountTest < ActiveSupport::TestCase

  test "associations" do
    assert_respond_to(Discount.new, :item)
    assert_respond_to(Discount.new, :standard_discount)
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

end
