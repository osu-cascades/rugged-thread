require "application_system_test_case"

class WorkOrdersTest < ApplicationSystemTestCase
  setup do
    @work_order = work_orders(:one)
  end

  test "visiting the index" do
    visit work_orders_url
    assert_selector "h1", text: "Work Orders"
  end

  test "creating a Work order" do
    visit work_orders_url
    click_on "New Work Order"

    fill_in "Estimate", with: @work_order.estimate
    fill_in "In date", with: @work_order.in_date
    check "Shipping" if @work_order.shipping
    click_on "Create Work order"

    assert_text "Work order was successfully created"
    click_on "Back"
  end

  test "updating a Work order" do
    visit work_orders_url
    click_on "Edit", match: :first

    fill_in "Estimate", with: @work_order.estimate
    fill_in "In date", with: @work_order.in_date
    check "Shipping" if @work_order.shipping
    click_on "Update Work order"

    assert_text "Work order was successfully updated"
    click_on "Back"
  end

  test "destroying a Work order" do
    visit work_orders_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Work order was successfully destroyed"
  end
end
