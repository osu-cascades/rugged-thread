require "test_helper"

class RepairTest < ActiveSupport::TestCase

  test "attributes" do
    assert_respond_to(Repair.new, :notes)
    assert_respond_to(Repair.new, :level)
    assert_respond_to(Repair.new, :price)
  end

  test "associations" do
    assert_respond_to(Repair.new, :item)
    assert_respond_to(Repair.new, :standard_repair)
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

end
