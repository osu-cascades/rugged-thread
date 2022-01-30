require "application_system_test_case"

class WorkOrdersTest < ApplicationSystemTestCase

  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:staff)
  end

  test "viewing a list of work orders" do
    visit work_orders_path
    assert_selector "h1", text: "Work Orders"
  end

  test "creating a work order" do
    visit new_work_order_path
    select customers(:one).full_name, from: :work_order_customer_id
    fill_in "In date", with: "1/1/2022"
    fill_in "Estimate", with: 1
    check "Shipping"
    click_on "Create Work order"
    assert_text "Work order was successfully created"
  end

  test "updating a Work order" do
    visit edit_work_order_path(work_orders(:shipping))
    fill_in "Estimate", with: 1000
    click_on "Update Work order"
    assert_text "Work order was successfully updated"
  end

  test "destroying a work order that has no items" do
    visit work_orders_path
    dom_id = "#work_order_#{work_orders(:itemless).id}"
    within(dom_id) { click_on "Delete" }
    assert_text "Work order was successfully destroyed"
  end

  test "failing to destroy a work order that has items" do
    visit work_orders_path
    dom_id = "#work_order_#{work_orders(:shipping).id}"
    within(dom_id) { click_on "Delete" }
    assert_text "Cannot delete this work order"
  end

end
