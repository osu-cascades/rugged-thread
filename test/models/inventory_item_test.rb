require "test_helper"

class InventoryItemTest < ActiveSupport::TestCase

  test "attributes" do
    assert_respond_to(InventoryItem.new, :price)
        assert_respond_to(InventoryItem.new, :price_cents)
  end

  test "associations" do
    assert_respond_to(InventoryItem.new, :standard_inventory_item)
  end

  test "must have a standard inventory item" do
    inventory_item = inventory_items(:one)
    assert inventory_item.valid?
    inventory_item.standard_inventory_item = nil
    refute inventory_item.valid?
  end

  test "price is a value object" do
    assert_equal Money.from_cents(100), InventoryItem.new(price: 1).price
    assert_equal Money.from_cents(200), InventoryItem.new(price: '2').price
    assert_equal Money.from_cents(300), InventoryItem.new(price: '3.00').price
  end

  test 'price must be a positive integer' do
    inventory_item = inventory_items(:one)
    assert inventory_item.valid?
    inventory_item.price = -1
    refute inventory_item.valid?
  end

  test '#name is the standard inventory item name' do
    inventory_item = inventory_items(:one)
    assert_equal inventory_item.standard_inventory_item.name, inventory_item.name
  end

  test '#to_s string representation is name' do
    inventory_item = inventory_items(:one)
    assert_equal inventory_item.name, inventory_item.to_s
  end

end