require "test_helper"

class ItemTest < ActiveSupport::TestCase

  test "belongs to a brand" do
    assert_respond_to(Item.new, :brand)
  end

  test "belongs to a work order" do
    assert_respond_to(Item.new, :work_order)
  end

  test "belongs to an item type" do
    assert_respond_to(Item.new, :item_type)
  end

  test "belongs to an item status" do
    assert_respond_to(Item.new, :item_status)
  end

end
