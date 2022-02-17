require "test_helper"

class FeeTest < ActiveSupport::TestCase

  test "attributes" do
    assert_respond_to(Fee.new, :price)
  end


  test "associations" do
    assert_respond_to(Fee.new, :item)
    assert_respond_to(Fee.new, :standard_fee)
  end

  test "must have a standard fee" do
    fee = fees(:one)
    assert fee.valid?
    fee.standard_fee = nil
    refute fee.valid?
  end

  test "must have an item" do
    fee = fees(:one)
    assert fee.valid?
    fee.item = nil
    refute fee.valid?
  end

  test "has a price that is the default fee price" do
    fee = Fee.new
    assert_equal(fee.price, 0)
  end

  test 'price must be a positive integer' do
    fee = fees(:one)
    assert fee.valid?
    fee.price = -1
    refute fee.valid?
  end

end
