require "test_helper"

class FeeTest < ActiveSupport::TestCase

  test "attributes" do
    assert_respond_to(Fee.new, :price)
    assert_respond_to(Fee.new, :price_cents)
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

  test "price is a value object" do
    assert_equal Money.from_cents(100), Fee.new(price: 1).price
    assert_equal Money.from_cents(200), Fee.new(price: '2').price
    assert_equal Money.from_cents(300), Fee.new(price: '3.00').price
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

  test '#name is the standard fee name' do
    fee = fees(:one)
    assert_equal fee.standard_fee.name, fee.name
  end

  test '#expedite? is true when the standard fee is the expedite standard fee' do
    fee = Fee.new
    refute fee.expedite?
    fee.standard_fee = StandardFee.new(name: StandardFee::EXPEDITE_FEE_NAME)
    assert fee.expedite?
  end

  test '#to_s string representation is name' do
    fee = fees(:one)
    assert_equal fee.name, fee.to_s
  end

end
