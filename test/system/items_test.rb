require "application_system_test_case"

class ItemsTest < ApplicationSystemTestCase

  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:staff)
  end

  test "visiting the index" do
    visit items_path
    assert_selector "h1", text: "Items"
  end

  test "Adding an item to a work order" do
    visit work_order_path(work_orders(:shipping))
    fill_in 'Due date', with: Date.current.to_s
    fill_in "Estimate", with: 1
    fill_in "Labor estimate", with: 2
    fill_in "Notes", with: 'FAKE'
    select item_statuses(:one).name, from: :item_item_status_id
    select brands(:one).name, from: :item_brand_id
    select item_types(:one).name, from: :item_item_type_id
    click_on "Create Item"
    assert_text "Item was successfully created"
  end

  test "updating a Item" do
    skip
    visit edit_item_path(items(:one))
    fill_in "Notes", with: 'Fake Updated Note'
    click_on "Update Item"
    assert_text "Item was successfully updated"
  end

  test "destroying an Item" do
    skip
    visit items_path
    click_on "Destroy", match: :first
    assert_text "Item was successfully destroyed"
  end

end
