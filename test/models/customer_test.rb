require "test_helper"

class CustomerTest < ActiveSupport::TestCase

  test "has many work orders" do
    assert_respond_to(Customer.new, :work_orders)
  end

  test 'cannot be deleted if it has associated work orders' do
    customer = customers(:one)
    assert_not_empty customer.work_orders
    customer.destroy
    refute customer.destroyed?
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
