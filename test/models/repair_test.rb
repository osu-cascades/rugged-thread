require "test_helper"

class RepairTest < ActiveSupport::TestCase

  test "attributes" do
    assert_respond_to(Repair.new, :notes)
    assert_respond_to(Repair.new, :level)
    assert_respond_to(Repair.new, :price)
    assert_respond_to(Repair.new, :price_cents)
  end

  test "associations" do
    assert_respond_to(Repair.new, :item)
    assert_respond_to(Repair.new, :standard_repair)
    assert_respond_to(Repair.new, :complications)
  end

  test 'cannot be deleted if it has associated complications' do
    repair = repairs(:one)
    assert_not_empty repair.complications
    repair.destroy
    refute repair.destroyed?
  end

  test 'can be deleted if it has no associated complications' do
    repair = repairs(:complicationless)
    assert_empty repair.complications
    repair.destroy
    assert repair.destroyed?
  end

  test "must have a standard repair" do
    repair = repairs(:one)
    assert repair.valid?
    repair.standard_repair = nil
    refute repair.valid?
  end

  test "must have an item" do
    repair = repairs(:one)
    assert repair.valid?
    repair.item = nil
    refute repair.valid?
  end

  test 'level must be a positive integer' do
    repair = repairs(:one)
    assert repair.valid?
    repair.level = -1
    refute repair.valid?
  end

  test 'level is 1 by default' do
    repair = Repair.new
    assert_equal 1, repair.level
  end

  test "price is a value object" do
    assert_equal Money.from_cents(100), Repair.new(price: 1).price
    assert_equal Money.from_cents(200), Repair.new(price: '2').price
    assert_equal Money.from_cents(300), Repair.new(price: '3.00').price
  end

  test "has a price that is the default repair price" do
    repair = Repair.new
    assert_equal(repair.price, 0)
  end

  test 'price must be a positive integer' do
    repair = repairs(:one)
    assert repair.valid?
    repair.price = -1
    refute repair.valid?
  end

  test "#price_of_labor is the price plus price of all complications" do
    repair = repairs(:complicationless)
    assert_equal(Money.from_cents(2000), repair.price_of_labor)
    repair.complications << Complication.new(price_cents: 500)
    assert_equal(Money.from_cents(2500), repair.price_of_labor)
    repair.complications << Complication.new(price_cents: 500)
    assert_equal(Money.from_cents(3000), repair.price_of_labor)
  end

  test "#total_price is the price_of_labor plus price of inventory items and special order items" do
    repair = repairs(:complicationless)
    assert_equal(Money.from_cents(2000), repair.total_price)
    repair.complications << Complication.new(price_cents: 500)
    repair.complications << Complication.new(price_cents: 500)
    assert_equal(Money.from_cents(3000), repair.total_price)
    repair.inventory_items << InventoryItem.new(price_cents: 500)
    repair.inventory_items << InventoryItem.new(price_cents: 500)
    assert_equal(Money.from_cents(4000), repair.total_price)
    repair.special_order_items << SpecialOrderItem.new(price_cents: 1000)
    repair.special_order_items << SpecialOrderItem.new(price_cents: 1000)
    assert_equal(Money.from_cents(6000), repair.total_price)
  end

  test "#total_price_of_inventory_items is the sum of the prices of all inventory items" do
    repair = repairs(:complicationless)
    assert_equal(Money.from_cents(0), repair.total_price_of_inventory_items)
    repair.inventory_items << InventoryItem.new(price_cents: 500)
    assert_equal(Money.from_cents(500), repair.total_price_of_inventory_items)
    repair.inventory_items << InventoryItem.new(price_cents: 1000)
    assert_equal(Money.from_cents(1500), repair.total_price_of_inventory_items)
  end

  test "#total_price_of_special_order_items is the sum of the prices of all special order items" do
    repair = repairs(:complicationless)
    assert_equal(Money.from_cents(0), repair.total_price_of_special_order_items)
    repair.special_order_items << SpecialOrderItem.new(price_cents: 500)
    assert_equal(Money.from_cents(500), repair.total_price_of_special_order_items)
    repair.special_order_items << SpecialOrderItem.new(price_cents: 1000)
    assert_equal(Money.from_cents(1500), repair.total_price_of_special_order_items)
  end

  test '#name is the standard_repair name' do
    repair = repairs(:one)
    assert_equal repair.standard_repair.name, repair.name
  end

  test '#method is the standard_repair method' do
    repair = repairs(:one)
    assert_equal repair.standard_repair.method, repair.method
  end

  test '#description is the standard_repair description' do
    repair = repairs(:one)
    assert_equal repair.standard_repair.description, repair.description
  end

  test '#to_s string representation is name' do
    repair = repairs.first
    assert_equal repair.name, repair.to_s
  end

end
