require "test_helper"

class FeeTest < ActiveSupport::TestCase

  test 'attributes' do
    assert_respond_to(Fee.new, :name)
    assert_respond_to(Fee.new, :price)
  end

  test 'must have a name' do
    fee = fees(:one)
    assert fee.valid?
    fee.name = nil
    refute fee.valid?
  end

  test 'name must be unique' do
    existing_fee_name = fees(:one).name
    fee = fees(:two)
    assert fee.valid?
    fee.name = existing_fee_name
    refute fee.valid?
  end

  test 'must have a numeric price' do
    fee = fees(:one)
    assert fee.valid?
    fee.price = 'FAKE'
    refute fee.valid?
  end

  test 'price cannot be negative or zero' do
    fee = fees(:one)
    assert fee.valid?
    fee.price = -1
    refute fee.valid?
    fee.price = 0
    refute fee.valid?
  end

  test '#to_s string representation is name' do
    name = 'FAKE'
    assert_equal(name, Fee.new(name: name).to_s)
  end

end
