require "application_system_test_case"

class WorkOrdersTest < ApplicationSystemTestCase

  include Devise::Test::IntegrationHelpers
  include ActionView::Helpers::NumberHelper

  setup do
    sign_in users(:staff)
  end

  test "viewing a list of work orders" do
    visit work_orders_path
    assert_selector "h1", text: "Work Orders"
  end

  test "viewing a work order's total estimate" do
    visit work_order_path(work_orders(:shipping))
    assert_text(work_orders(:shipping).price.format)
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
    fill_in 'Due date', with: (Date.current + 1.day)
    check "Shipping"
    click_on "Create Work order"
    assert_text "Work order was successfully created"
  end

  test "creating a work order fails without a customer" do
    visit new_work_order_path
    select '', from: :work_order_customer_id
    fill_in 'Due date', with: (Date.current + 1.day)
    click_on "Create Work order"
    assert_text "error prohibited this work order from being saved"
  end

  test "creating a work order fails when due date is not past the in date" do
    visit new_work_order_path
    select customers(:one).full_name, from: :work_order_customer_id
    fill_in 'Due date', with: find_field('In date').value
    click_on "Create Work order"
    assert_text "error prohibited this work order from being saved"
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
    assert_text "This work order cannot be deleted, it still has items associated with it."
  end

  # In date

  test "new work order's in date is filled in by default" do
    visit new_work_order_path
    assert has_field?('In date', with: Date.current)
  end

  test "creating a work order with a custom in date" do
    custom_in_date = Date.current - 1.day
    visit new_work_order_path
    select customers(:one).full_name, from: :work_order_customer_id
    fill_in 'In date', with: custom_in_date
    click_on "Create Work order"
    assert_text "Work order was successfully created"
    assert_text "Date in: #{custom_in_date.to_formatted_s(:long)}"
  end

  test "updating a work order's in date" do
    new_in_date = Date.current - 1.day
    visit edit_work_order_path(work_orders(:shipping))
    fill_in 'In date', with: new_in_date
    click_on "Update Work order"
    assert_text "Work order was successfully updated"
    assert_text "Date in: #{new_in_date.to_formatted_s(:long)}"
  end

  # Due date

  test "new work order's due date is filled in by default" do
    visit new_work_order_path
    assert has_field?('Due date', with: find_field('In date').value)
  end

  test "creating a work order with a custom due date" do
    custom_due_date = Date.current + 1.day
    visit new_work_order_path
    select customers(:one).full_name, from: :work_order_customer_id
    fill_in 'Due date', with: custom_due_date
    click_on "Create Work order"
    assert_text "Work order was successfully created"
    assert_text "Due date: #{custom_due_date.to_formatted_s(:long)}"
  end

  test "updating a work order's due date" do
    new_due_date = Date.current + 10.days
    visit edit_work_order_path(work_orders(:shipping))
    fill_in 'Due date', with: new_due_date
    click_on "Update Work order"
    assert_text "Work order was successfully updated"
    assert_text "Due date: #{new_due_date.to_formatted_s(:long)}"
  end

  test "new work order with known customer has a due date based on that customer type turn around" do
    customer = customers.first
    visit new_customer_work_order_path(customer)
    assert has_field?('Due date', with: Date.current + customer.customer_type.turn_around.days)
  end

  test "archiving a work order that has items succeeds" do
    visit work_order_path(work_orders(:shipping))
    click_on 'Archive'
    assert_text "Work order was successfully archived."
  end

  test "recovering a work order succeeds" do
    visit work_orders_path
    refute_text work_orders(:archived).number
    visit work_order_path(work_orders(:archived))
    click_on 'Recover'
    assert_text "Work Order was successfully recovered."
  end

end
