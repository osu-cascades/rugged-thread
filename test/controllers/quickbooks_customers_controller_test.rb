require "test_helper"

class QuickbooksCustomersControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get quickbooks_customers_show_url
    assert_response :success
  end
end
