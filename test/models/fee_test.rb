require "test_helper"

class FeeTest < ActiveSupport::TestCase

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

end
