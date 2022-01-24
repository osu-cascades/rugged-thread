require "application_system_test_case"

class WorkOrdersTest < ApplicationSystemTestCase

  include Devise::Test::IntegrationHelpers

  setup do
    @work_order = work_orders(:one)
    sign_in users(:staff)
  end

  test "visiting the index" do
    visit work_orders_path
    assert_selector "h1", text: "Work Orders"
  end

  test "creating a Work order" do
    visit work_orders_path
    click_on "New Work Order"

    fill_in "Estimate", with: @work_order.estimate
    check "Shipping" if @work_order.shipping
    click_on "Create Work order"

    assert_text "Work order was successfully created"
    click_on "Back"
  end

  test "updating a Work order" do
    visit work_orders_path
    click_on "Edit", match: :first

    fill_in "Estimate", with: @work_order.estimate
    check "Shipping" if @work_order.shipping
    click_on "Update Work order"

    assert_text "Work order was successfully updated"
    click_on "Back"
  end

  test "destroying a Work order" do
    visit work_orders_path
    click_on "Destroy", match: :first
    assert_text "Work order was successfully destroyed"
  end
end
