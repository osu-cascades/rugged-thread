require "test_helper"

class ItemTest < ActiveSupport::TestCase

  test "attributes" do
    assert_respond_to(Item.new, :due_date)
    assert_respond_to(Item.new, :estimate)
    assert_respond_to(Item.new, :labor_estimate)
    assert_respond_to(Item.new, :notes)
  end

  test "associations" do
    assert_respond_to(Item.new, :brand)
    assert_respond_to(Item.new, :item_status)
    assert_respond_to(Item.new, :item_type)
    assert_respond_to(Item.new, :work_order)
    assert_respond_to(Item.new, :repairs)
  end

  test "has a status that is the default item status" do
    item = Item.new
    assert_equal(ItemStatus.default, item.item_status)
  end

  test "#estimate is labor_estimate plus parts, special order, minus standard discounts" do
    item = items(:repairless)
    assert_equal(0, item.estimate)
    item.repairs << Repair.new(price: 3)
    assert_equal(3, item.estimate)
  end

  test "#labor_estimate is the sum of all repair prices" do
    item = items(:repairless)
    assert_equal(0, item.labor_estimate)
    item.repairs << Repair.new(price: 3)
    assert_equal(3, item.labor_estimate)
    item.repairs << Repair.new(price: 7)
    assert_equal(10, item.labor_estimate)
  end

  test "#parts_special_orders_standard_discounts returns 0 for now" do
    skip
  end

end
