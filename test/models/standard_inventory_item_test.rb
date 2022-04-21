require "test_helper"

class StandardInventoryItemTest < ActiveSupport::TestCase

  test "attributes" do
    assert_respond_to(StandardInventoryItem.new, :name)
    assert_respond_to(StandardInventoryItem.new, :sku)
    assert_respond_to(StandardInventoryItem.new, :price)
    assert_respond_to(StandardInventoryItem.new, :price_cents)
  end

  test "associations" do
    assert_respond_to(StandardInventoryItem.new, :inventory_items)
  end

  test "cannot be deleted if it has associated inventory items" do
    standard_inventory_item = standard_inventory_items(:one)
    assert_not_empty standard_inventory_item.inventory_items
    standard_inventory_item.destroy
    refute standard_inventory_item.destroyed?
  end

  test "is not valid without a name" do
    standard_inventory_item = standard_inventory_items(:one)
    assert standard_inventory_item.valid?
    standard_inventory_item.name = ''
    refute standard_inventory_item.valid?
  end

  test "name must be unique" do
    existing_standard_inventory_item_name = standard_inventory_items(:one).name
    standard_inventory_item = standard_inventory_items(:two)
    assert standard_inventory_item.valid?
    standard_inventory_item.name = existing_standard_inventory_item_name
    refute standard_inventory_item.valid?
  end

  test "is not valid without a sku" do
    standard_inventory_item = standard_inventory_items(:one)
    assert standard_inventory_item.valid?
    standard_inventory_item.sku = ''
    refute standard_inventory_item.valid?
  end

  test "sku must be unique" do
    existing_standard_inventory_item_sku = standard_inventory_items(:one).sku
    standard_inventory_item = standard_inventory_items(:two)
    assert standard_inventory_item.valid?
    standard_inventory_item.sku = existing_standard_inventory_item_sku
    refute standard_inventory_item.valid?
  end

  test "price is a value object" do
    assert_equal Money.from_cents(100), StandardInventoryItem.new(price: 1).price
    assert_equal Money.from_cents(200), StandardInventoryItem.new(price: '2').price
    assert_equal Money.from_cents(300), StandardInventoryItem.new(price: '3.00').price
  end

  test "price must be a non-negative integer" do
    standard_inventory_item = standard_inventory_items(:one)
    assert standard_inventory_item.valid?
    standard_inventory_item.price = -1
    refute standard_inventory_item.valid?
  end

  test "#to_s string representation is name" do
    name = 'FAKE'
    standard_inventory_item = StandardInventoryItem.new(name: name)
    assert_equal name, standard_inventory_item.to_s
  end

end
