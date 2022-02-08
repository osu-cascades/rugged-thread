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

end
