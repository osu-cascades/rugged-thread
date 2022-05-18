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

  test "open order total price is the sum of all kept non-invoiced items" do
    total_price_of_non_invoiced_items = Item.kept.not_invoiced.reduce(0) { |sum, i| sum + i.price }
    number_of_non_invoiced_items = Item.kept.not_invoiced.count
    visit dashboard_path
    assert_text total_price_of_non_invoiced_items.format
    assert_text "#{number_of_non_invoiced_items} items not yet invoiced"
  end

end
