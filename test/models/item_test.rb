require "test_helper"

class ItemTest < ActiveSupport::TestCase

  test "attributes" do
    assert_respond_to(Item.new, :due_date)
    assert_respond_to(Item.new, :estimate)
    assert_respond_to(Item.new, :labor_estimate)
    assert_respond_to(Item.new, :notes)
    assert_respond_to(Item.new, :shipping)
  end

  test "associations" do
    assert_respond_to(Item.new, :brand)
    assert_respond_to(Item.new, :item_status)
    assert_respond_to(Item.new, :item_type)
    assert_respond_to(Item.new, :work_order)
    assert_respond_to(Item.new, :repairs)
  end

  test "can be deleted if it has no associated repairs, discounts, or fees" do
    item = items(:associationless)
    assert_empty item.repairs
    assert_empty item.discounts
    assert_empty item.fees
    item.destroy
    assert item.destroyed?
  end

  test "cannot be deleted if it has repairs" do
    item = items(:one)
    assert_not_empty item.repairs
    item.destroy
    refute item.destroyed?
  end

  test "cannot be deleted if it has discounts" do
    item = items(:one)
    assert_not_empty item.discounts
    item.destroy
    refute item.destroyed?
  end

  test "cannot be deleted if it has fees" do
    item = items(:one)
    assert_not_empty item.fees
    item.destroy
    refute item.destroyed?
  end

  test "must have a brand" do
    item = items(:one)
    assert item.valid?
    item.brand = nil
    refute item.valid?
  end

  test "must have a status" do
    item = items(:one)
    assert item.valid?
    item.item_status = nil
    refute item.valid?
  end

  test "must have a type" do
    item = items(:one)
    assert item.valid?
    item.item_type = nil
    refute item.valid?
  end

  test "must have a work order" do
    item = items(:one)
    assert item.valid?
    item.work_order = nil
    refute item.valid?
  end

  test "has a status that is the default item status" do
    item = Item.new
    assert_equal(ItemStatus.default, item.item_status)
  end

  test "shipping must be true or false" do
    item = items(:one)
    assert item.valid?
    item.shipping = nil
    refute item.valid?
  end

  test "shipping is the same as its work order upon build" do
    shipping_work_order = work_orders(:shipping)
    item = shipping_work_order.items.build
    assert shipping_work_order.shipping
    assert item.shipping
    not_shipped_work_order = work_orders(:not_shipping)
    item = not_shipped_work_order.items.build
    refute not_shipped_work_order.shipping
    refute item.shipping
  end

  test "shipping is nil when created without a work order" do
    assert_nil Item.new.shipping
  end

  test "shipping does not update to match work order when item is already persisted" do
    item = items(:one)
    assert_equal item.work_order.shipping, item.shipping
    item.shipping = !item.work_order.shipping
    item.save!
    item = items(:one)
    refute_equal item.work_order.shipping, item.shipping
  end

  test "#estimate is labor_estimate plus parts, special order, minus standard discounts" do
    item = items(:associationless)
    assert_equal(0, item.estimate)
    item.repairs << Repair.new(price: 3)
    assert_equal(3, item.estimate)
  end

  test "#labor_estimate is the sum of all repair prices" do
    item = items(:associationless)
    assert_equal(0, item.labor_estimate)
    item.repairs << Repair.new(price: 3)
    assert_equal(3, item.labor_estimate)
    item.repairs << Repair.new(price: 7)
    assert_equal(10, item.labor_estimate)
  end

  test "#fees_and_discounts returns 0 for now" do
    skip
  end

  test "#level is the maximum level of its repirs" do
    assert_equal(3, items(:one).level)
  end

end
