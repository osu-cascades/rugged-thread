require "test_helper"

class RepairTest < ActiveSupport::TestCase

  test "attributes" do
    assert_respond_to(Repair.new, :notes)
    assert_respond_to(Repair.new, :price)
  end

  test "associations" do
    assert_respond_to(Repair.new, :item)
    assert_respond_to(Repair.new, :standard_repair)
  end

end
