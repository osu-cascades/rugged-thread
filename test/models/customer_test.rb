require "test_helper"

class CustomerTest < ActiveSupport::TestCase

  test 'attributes' do
    assert_respond_to(Customer.new, :first_name)
    assert_respond_to(Customer.new, :last_name)
    assert_respond_to(Customer.new, :business_name)
    assert_respond_to(Customer.new, :phone_number)
    assert_respond_to(Customer.new, :alternative_phone_number)
    assert_respond_to(Customer.new, :email_address)
    assert_respond_to(Customer.new, :shipping_street_address)
    assert_respond_to(Customer.new, :shipping_city)
    assert_respond_to(Customer.new, :shipping_state)
    assert_respond_to(Customer.new, :shipping_zip_code)
    assert_respond_to(Customer.new, :billing_street_address)
    assert_respond_to(Customer.new, :billing_city)
    assert_respond_to(Customer.new, :billing_state)
    assert_respond_to(Customer.new, :billing_zip_code)
  end

  test 'assocations' do
    assert_respond_to(Customer.new, :customer_type)
    assert_respond_to(Customer.new, :work_orders)
  end

  test 'cannot be deleted if it has associated work orders' do
    customer = customers(:one)
    assert_not_empty customer.work_orders
    customer.destroy
    refute customer.destroyed?
  end

  test 'Customer has a valid phone number' do
    customer = customers(:one)
    assert customer.valid?
    customer.phone_number = '1234567891011'
    refute customer.valid?
  end

  test "full name is first and last name" do
    customer = customers(:one)
    assert_equal("#{customer.first_name} #{customer.last_name}", customer.full_name)
  end

  test "#to_s returns the full name" do
    customer = customers(:one)
    full_name = "#{customer.first_name} #{customer.last_name}"
    assert_equal(full_name, customer.to_s)
  end

end
