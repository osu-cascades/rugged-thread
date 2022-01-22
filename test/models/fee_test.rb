require "test_helper"

class FeeTest < ActiveSupport::TestCase
  test 'Fee has a description' do
    assert_respond_to(Fee.new, :description)
  end


  test 'Fee without a description is invalid' do
    fee = fees(:one)
    assert fee.valid?
    fee.description = nil
    refute fee.valid?
  end

  test 'Fee without a non-integer value is invalid' do
    fee = fees(:one)
    assert fee.valid?
    fee.price = "FakePrice"
    refute fee.valid?
  end

  test 'Fee with a non-unique description is invalid' do
    existing_fee_description = fees(:one).description
    fee = fees(:two)
    assert fee.valid?
    fee.description = existing_fee_description
    refute fee.valid?
  end
end
