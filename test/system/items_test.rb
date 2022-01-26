require "application_system_test_case"

class ItemsTest < ApplicationSystemTestCase

  include Devise::Test::IntegrationHelpers

  setup do
    @item = items(:one)
    sign_in users(:staff)
  end

  test "visiting the index" do
    visit items_path
    assert_selector "h1", text: "Items"
  end

  test "creating a Item" do
    visit items_path
    click_on "New Item"

    select items(:one).brand, from: :item_brand_id
    fill_in "Due date", with: @item.due_date
    fill_in "Estimate", with: @item.estimate
    fill_in "Item type", with: @item.item_type_id
    fill_in "Labor estimate", with: @item.labor_estimate
    fill_in "Notes", with: @item.notes
    select items(:one).status
    fill_in "Work order", with: @item.work_order_id
    click_on "Create Item"

    assert_text "Item was successfully created"
    click_on "Back"
  end

  test "updating a Item" do
    visit items_path
    click_on "Edit", match: :first

    select items(:one).brand, from: :item_brand_id
    fill_in "Due date", with: @item.due_date
    fill_in "Estimate", with: @item.estimate
    fill_in "Item type", with: @item.item_type_id
    fill_in "Labor estimate", with: @item.labor_estimate
    fill_in "Notes", with: @item.notes
    select items(:one).status
    fill_in "Work order", with: @item.work_order_id
    click_on "Update Item"

    assert_text "Item was successfully updated"
    click_on "Back"
  end

  test "destroying a Item" do
    visit items_path
    click_on "Destroy", match: :first
    assert_text "Item was successfully destroyed"
  end
end
