require "test_helper"

class CustomerTypeTest < ActiveSupport::TestCase

  test 'Customer Type has a name' do
    assert_respond_to(CustomerType.new, :name)
  end

  test 'Customer Type without a name is invalid' do
    customer_type = customer_types(:one)
    assert customer_type.valid?
    customer_type.name = nil
    refute customer_type.valid?
  end

  test 'Customer Type with a non-unique name is invalid' do
    existing_customer_type_name = customer_types(:one).name
    customer_type = customer_types(:two)
    assert customer_type.valid?
    customer_type.name = existing_customer_type_name
    refute customer_type.valid?
  end

  test '#to_s string representation is name' do
    name = 'FAKE'
    customer_type = CustomerType.new(name: name)
    assert_equal name, customer_type.to_s
  end

end
