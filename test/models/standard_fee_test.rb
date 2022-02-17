require "test_helper"

class StandardFeeTest < ActiveSupport::TestCase

  test 'attributes' do
    assert_respond_to(StandardFee.new, :name)
    assert_respond_to(StandardFee.new, :price)
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

  test 'must have a numeric price' do
    standard_fee = standard_fees(:one)
    assert standard_fee.valid?
    standard_fee.price = 'FAKE'
    refute standard_fee.valid?
  end

  test 'price cannot be negative or zero' do
    standard_fee = standard_fees(:one)
    assert standard_fee.valid?
    standard_fee.price = -1
    refute standard_fee.valid?
    standard_fee.price = 0
    refute standard_fee.valid?
  end

  test '#to_s string representation is name' do
    name = 'FAKE'
    assert_equal(name, StandardFee.new(name: name).to_s)
  end

end
