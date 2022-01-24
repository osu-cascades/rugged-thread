require "test_helper"

class CustomerTest < ActiveSupport::TestCase
  test "full name is first and last name" do
    customer = customers(:one)
    assert_equal("#{customer.first_name} #{customer.last_name}", customer.full_name)
  end
end
