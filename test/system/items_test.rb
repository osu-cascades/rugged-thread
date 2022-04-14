require "application_system_test_case"

class ItemsTest < ApplicationSystemTestCase

  include Devise::Test::IntegrationHelpers
  include ActionView::Helpers::NumberHelper

  setup do
    sign_in users(:staff)
  end

  test "visiting the index shows a table of all items, each with a Details link" do
    visit items_path
    assert_selector "h1", text: "Items"
    assert_selector "#items_table"
    assert_link 'Details'
  end

  test "viewing an item's total estimate" do
    visit item_path(items(:one))
    assert_text("$#{items(:one).price_estimate}")
  end

  test "new item's item status is the default one" do
    default_item_status = item_statuses(:default)
    visit work_order_path(work_orders(:shipping))
    assert(page.has_select?('Item status', selected: default_item_status.name))
  end

  test "new item's shipping checkbox matches its work order shipping" do
    visit work_order_path(work_orders(:shipping))
    within('#item_form') { assert has_checked_field? 'Shipping' }
    visit work_order_path(work_orders(:not_shipping))
    within('#item_form') { refute has_checked_field? 'Shipping' }
  end

  test "Adding an item to a work order" do
    visit work_order_path(work_orders(:shipping))
    fill_in 'Due date', with: (Date.current + 10.days)
    fill_in "Notes", with: 'FAKE'
    select item_statuses(:one).name, from: :item_item_status_id
    select brands(:one).name, from: :item_brand_id
    select item_types(:one).name, from: :item_item_type_id
    click_on "Add Item"
    assert_text "Item was successfully created"
  end

  test "Adding an item to a work order with a different shipping attribute" do
    visit work_order_path(work_orders(:not_shipping))
    within '#items_table' do
      within all('tr').last do
        refute_text '📦'
      end
    end
    fill_in 'Due date', with: (Date.current + 10.days)
    fill_in "Notes", with: 'FAKE'
    check 'Shipping'
    select item_statuses(:one).name, from: :item_item_status_id
    select brands(:one).name, from: :item_brand_id
    select item_types(:one).name, from: :item_item_type_id
    click_on "Add Item"
    assert_text "Item was successfully created"
    click_on "Back to Work Order"
    within '#items_table' do
      within all('tr').last do
        assert_text '📦'
      end
    end
  end

  test "Adding an invalid item redisplays the work order view with errors" do
    visit work_order_path(work_orders(:shipping))
    click_on 'Add Item'
    assert_text 'prohibited this item from being saved'
  end

  test "updating an item" do
    visit edit_item_path(items(:one))
    fill_in "Notes", with: 'Fake Updated Note'
    click_on "Update Item"
    assert_text "Item was successfully updated"
  end

  test "updating an item's status" do
    item = items(:one)
    new_status = item_statuses(:two)
    refute_equal new_status, item.item_status
    visit edit_item_path(item)
    select new_status.name, from: 'Item status'
    click_on "Update Item"
    assert_text "Item was successfully updated"
    assert_text new_status.name
  end

  test "updating an item's shipping" do
    item = work_orders(:shipping).items.first
    assert item.shipping
    visit edit_item_path(item)
    uncheck 'Shipping'
    click_on "Update Item"
    assert_text "Item was successfully updated"
    assert_text "Ship? no"
  end

  test 'updating an invalid item redisplays the edit view with errors' do
    visit edit_item_path(items(:one))
    select '', from: 'Brand'
    click_on "Update Item"
    assert_text "prohibited this item from being saved"
  end

  test "destroying an item without repairs, discounts and fees succeeds" do
    visit item_path(items(:associationless))
    click_on 'Delete'
    assert_text "Item was successfully destroyed"
  end

  test "destroying an item with repairs fails" do
    visit item_path(items(:with_only_repair))
    click_on 'Delete'
    assert_text "Cannot delete this item"
  end

  test "destroying an item with discounts fails" do
    visit item_path(items(:with_only_discount))
    click_on 'Delete'
    assert_text "Cannot delete this item"
  end

  test "destroying an item with fees fails" do
    visit item_path(items(:with_only_fee))
    click_on 'Delete'
    assert_text "Cannot delete this item"
  end

  # Due date

  test "new item's due date matches its work order due date" do
    work_order = work_orders(:shipping)
    visit work_order_path(work_order)
    within('#item_form') { assert has_field? 'Due date', with: work_order.due_date }
  end

  test "Adding an item to a work order with a different due date" do
    work_order = work_orders(:itemless)
    custom_due_date = work_order.due_date + 10.days
    refute_equal work_order.due_date, custom_due_date
    visit work_order_path(work_order)
    fill_in 'Due date', with: custom_due_date
    select brands(:one).name, from: :item_brand_id
    select item_types(:one).name, from: :item_item_type_id
    click_on "Add Item"
    assert_text "Item was successfully created"
    click_on "Back to Work Order"
    within '#items_table' do
      within all('tr').last do
        assert_text custom_due_date.to_formatted_s(:long)
      end
    end
  end

  test "Adding an item to a work order with a due date older than its work order in date fails" do
    work_order = work_orders(:itemless)
    invalid_due_date = work_order.in_date
    visit work_order_path(work_order)
    fill_in 'Due date', with: invalid_due_date
    select brands(:one).name, from: :item_brand_id
    select item_types(:one).name, from: :item_item_type_id
    click_on "Add Item"
    assert_text "prohibited this item from being saved"
    assert_text "Due date must be"
  end

end
