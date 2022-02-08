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

  test "viewing a work order's total estimate" do
    visit work_order_path(work_orders(:shipping))
    assert_text("$#{work_orders(:shipping).estimate}")
  end


  test "new work order default creator is current_user" do
    sign_in(users(:staff))
    visit new_work_order_path
    creator_id = find("#work_order_creator_id").value
    assert(page.has_select?('Creator', selected: users(:staff).name))
    sign_in(users(:admin))
    visit new_work_order_path
    creator_id = find("#work_order_creator_id").value
    assert(page.has_select?('Creator', selected: users(:admin).name))
  end

  test "creating a work order" do
    visit new_work_order_path
    select customers(:one).full_name, from: :work_order_customer_id
    fill_in "In date", with: "1/1/2022"
    check "Shipping"
    click_on "Create Work order"
    assert_text "Work order was successfully created"
  end

  test "updating a Work order" do
    visit edit_work_order_path(work_orders(:shipping))
    click_on "Update Work order"
    assert_text "Work order was successfully updated"
  end

  test "destroying a work order that has no items" do
    visit work_order_path(work_orders(:itemless))
    click_on 'Delete'
    assert_text "Work order was successfully destroyed"
  end

  test "failing to destroy a work order that has items" do
    visit work_order_path(work_orders(:shipping))
    click_on 'Delete'
    assert_text "Cannot delete this work order"
  end

end
