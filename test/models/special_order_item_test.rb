require "test_helper"

class SpecialOrderItemTest < ActiveSupport::TestCase
  test "attributes" do
    assert_respond_to(SpecialOrderItem.new, :name)
    assert_respond_to(SpecialOrderItem.new, :price)
  end

  test 'Special Orer Item without a name is invalid' do
    special_order_item = special_order_items(:one)
    assert special_order_item.valid?
    special_order_item.name = nil
    refute special_order_item.valid?
  end


  test 'price must be a positive integer' do
    special_order_item = special_order_items(:one)
    assert special_order_item.valid?
    special_order_item.price = -1
    refute special_order_item.valid?
  end


  test '#to_s string representation is name' do
    special_order_item = special_order_items(:one)
    assert_equal special_order_item.name, special_order_item.to_s
  end
end
