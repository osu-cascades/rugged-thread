require "application_system_test_case"

class DashboardTest < ApplicationSystemTestCase

  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:staff)
  end

  test "viewing the dashboard" do
    visit dashboard_path
    assert_selector "h1", text: "Dashboard"
  end

end
