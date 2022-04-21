require "test_helper"

class SpecialOrderItemTest < ActiveSupport::TestCase
  test "attributes" do
    assert_respond_to(SpecialOrderItem.new, :name)
    assert_respond_to(SpecialOrderItem.new, :price)
    assert_respond_to(SpecialOrderItem.new, :price_cents)
    assert_respond_to(SpecialOrderItem.new, :ordering_fee_price)
    assert_respond_to(SpecialOrderItem.new, :ordering_fee_price_cents)
    assert_respond_to(SpecialOrderItem.new, :freight_fee_price)
    assert_respond_to(SpecialOrderItem.new, :freight_fee_price_cents)
  end

  test 'name must be present' do
    special_order_item = special_order_items(:one)
    assert special_order_item.valid?
    special_order_item.name = nil
    refute special_order_item.valid?
  end

  test "price is a value object" do
    assert_equal Money.from_cents(100), SpecialOrderItem.new(price: 1).price
    assert_equal Money.from_cents(200), SpecialOrderItem.new(price: '2').price
    assert_equal Money.from_cents(300), SpecialOrderItem.new(price: '3.00').price
  end

  test 'price must be a positive integer' do
    special_order_item = special_order_items(:one)
    assert special_order_item.valid?
    special_order_item.price = -1
    refute special_order_item.valid?
  end

  test "ordering fee price is a value object" do
    assert_equal Money.from_cents(100), SpecialOrderItem.new(ordering_fee_price: 1).ordering_fee_price
    assert_equal Money.from_cents(200), SpecialOrderItem.new(ordering_fee_price: '2').ordering_fee_price
    assert_equal Money.from_cents(300), SpecialOrderItem.new(ordering_fee_price: '3.00').ordering_fee_price
  end

  test 'ordering fee price must be a positive integer' do
    special_order_item = special_order_items(:one)
    assert special_order_item.valid?
    special_order_item.ordering_fee_price = -1
    refute special_order_item.valid?
  end

  test "freight fee price is a value object" do
    assert_equal Money.from_cents(100), SpecialOrderItem.new(freight_fee_price: 1).freight_fee_price
    assert_equal Money.from_cents(200), SpecialOrderItem.new(freight_fee_price: '2').freight_fee_price
    assert_equal Money.from_cents(300), SpecialOrderItem.new(freight_fee_price: '3.00').freight_fee_price
  end

  test 'freight fee price must be a positive integer' do
    special_order_item = special_order_items(:one)
    assert special_order_item.valid?
    special_order_item.freight_fee_price = -1
    refute special_order_item.valid?
  end

  test '#total_price is sum of price, ordering fee, and freight fee' do
    special_order_item = SpecialOrderItem.new(price: 1, ordering_fee_price: 3, freight_fee_price: 5)
    assert_equal Money.from_cents(900), special_order_item.total_price
  end

  test '#to_s string representation is name' do
    special_order_item = special_order_items(:one)
    assert_equal special_order_item.name, special_order_item.to_s
  end

end
