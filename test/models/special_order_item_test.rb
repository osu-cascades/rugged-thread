require "test_helper"

class SpecialOrderItemTest < ActiveSupport::TestCase
  test "attributes" do
    assert_respond_to(SpecialOrderItem.new, :name)
    assert_respond_to(SpecialOrderItem.new, :price)
    assert_respond_to(SpecialOrderItem.new, :ordering_fee_price)
    assert_respond_to(SpecialOrderItem.new, :freight_fee_price)
  end

  test 'name must be present' do
    special_order_item = special_order_items(:one)
    assert special_order_item.valid?
    special_order_item.name = nil
    refute special_order_item.valid?
  end

  test 'price must be a positive integer' do
    special_order_item = special_order_items(:one)
    assert special_order_item.valid?
    special_order_item.price = nil
    refute special_order_item.valid?
    special_order_item.price = -1
    refute special_order_item.valid?
  end

  test 'ordering fee price must be a positive integer' do
    special_order_item = special_order_items(:one)
    assert special_order_item.valid?
    special_order_item.ordering_fee_price = nil
    refute special_order_item.valid?
    special_order_item.ordering_fee_price = -1
    refute special_order_item.valid?
  end

  test 'freight fee price must be a positive integer' do
    special_order_item = special_order_items(:one)
    assert special_order_item.valid?
    special_order_item.freight_fee_price = nil
    refute special_order_item.valid?
    special_order_item.freight_fee_price = -1
    refute special_order_item.valid?
  end

  test '#to_s string representation is name' do
    special_order_item = special_order_items(:one)
    assert_equal special_order_item.name, special_order_item.to_s
  end

end
