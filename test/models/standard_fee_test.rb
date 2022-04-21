require "test_helper"

class StandardFeeTest < ActiveSupport::TestCase

  test 'attributes' do
    assert_respond_to(StandardFee.new, :name)
    assert_respond_to(StandardFee.new, :price)
    assert_respond_to(StandardFee.new, :price_cents)
  end

  test "associations" do
    assert_respond_to(StandardFee.new, :fees)
  end

  test 'must have a name' do
    standard_fee = standard_fees(:one)
    assert standard_fee.valid?
    standard_fee.name = nil
    refute standard_fee.valid?
  end

  test 'name must be unique' do
    existing_standard_fee_name = standard_fees(:one).name
    standard_fee = standard_fees(:feeless)
    assert standard_fee.valid?
    standard_fee.name = existing_standard_fee_name
    refute standard_fee.valid?
  end

  test "price is a value object" do
    assert_equal Money.from_cents(100), StandardFee.new(price: 1).price
    assert_equal Money.from_cents(200), StandardFee.new(price: '2').price
    assert_equal Money.from_cents(300), StandardFee.new(price: '3.00').price
  end

  test 'price must be positive' do
    standard_fee = standard_fees(:one)
    assert standard_fee.valid?
    standard_fee.price = -1
    refute standard_fee.valid?
  end

  test "::expedite returns the fee with the 'Expedite' name" do
    expedite_fee = StandardFee.expedite
    assert_equal StandardFee::EXPEDITE_FEE_NAME, expedite_fee.name
  end

  test "#expedite? is true when the name is 'Expedite'" do
    assert StandardFee.new(name: StandardFee::EXPEDITE_FEE_NAME).expedite?
  end

  test '#to_s string representation is name' do
    name = 'FAKE'
    assert_equal(name, StandardFee.new(name: name).to_s)
  end

end
