require "test_helper"

class CustomerTypeTest < ActiveSupport::TestCase

  test 'attributes' do
    assert_respond_to(CustomerType.new, :name)
    assert_respond_to(CustomerType.new, :customers_count)
    assert_respond_to(CustomerType.new, :turn_around)
    assert_respond_to(CustomerType.new, :q_customer_type_id)
  end

  test 'associations' do
    assert_respond_to(CustomerType.new, :customers)
  end

  test 'cannot be deleted if it has associated customers' do
    customer_type = customers.first.customer_type
    assert_not_empty customer_type.customers
    customer_type.destroy
    refute customer_type.destroyed?
  end

  test 'must have a name' do
    customer_type = customer_types(:one)
    assert customer_type.valid?
    customer_type.name = nil
    refute customer_type.valid?
  end

  test 'name must be unique' do
    existing_customer_type_name = customer_types(:one).name
    customer_type = customer_types(:two)
    assert customer_type.valid?
    customer_type.name = existing_customer_type_name
    refute customer_type.valid?
  end

  test 'must have a numeric turn_around greater than 0' do
    customer_type = customer_types(:one)
    assert customer_type.valid?
    customer_type.turn_around = -1
    refute customer_type.valid?
    customer_type.turn_around = 0
    refute customer_type.valid?
  end

  test '#to_s string representation is name' do
    name = 'FAKE'
    customer_type = CustomerType.new(name: name)
    assert_equal name, customer_type.to_s
  end

end
