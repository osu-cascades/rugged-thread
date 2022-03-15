require "application_system_test_case"

class SpecialOrderItemsTest < ApplicationSystemTestCase

  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:staff)
  end

  test "visiting the index shows a table of all special order items, each with a Details link" do
    visit special_order_items_path
    assert_selector "h1", text: "Special Order Items"
    assert_selector "#special_order_items_table"
    assert_link 'Details'
  end

  test "viewing a list of special order items for a repair" do
    repair = repairs(:one)
    visit repair_path(repair)
    assert_text repair.special_order_items.first.name
  end

  test "creating a special_order_item for an repair" do
    visit repair_path(repairs(:one))
    fill_in "Name", with: 'New Fake Name'
    fill_in "special_order_item_price", with: 1
    fill_in "special_order_item_ordering_fee_price", with: 2
    fill_in "special_order_item_freight_fee_price", with: 3
    click_on "Add Special order item"
    assert_text "Special Order Item was successfully created"
  end

  test "Adding an invalid special_order_item redisplays the repair view with errors" do
    visit repair_path(repairs(:one))
    click_on 'Add Special order item'
    assert_text 'prohibited this special order item from being saved'
  end

  test "updating a special_order_item" do
    visit edit_special_order_item_path(special_order_items(:one))
    fill_in "Price", with: 1000
    click_on "Update Special order item"
    assert_text "Special Order Item was successfully updated"
  end

  test "updating an invalid special_order_item redisplays the edit view with errors" do
    visit edit_special_order_item_path(special_order_items(:one))
    fill_in "Name", with: ''
    fill_in "Price", with: 20
    click_on "Update Special order item"
    assert_text "prohibited this special order item from being saved"
  end

  test "destroying a special_order_item succeeds" do
    visit special_order_item_path(special_order_items(:one))
    click_on "Delete"
    assert_text "Special Order Item was successfully destroyed"
  end

end