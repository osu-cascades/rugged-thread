require "application_system_test_case"

class InventoryItemsTest < ApplicationSystemTestCase

  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:staff)
  end

  test "visiting the index shows a table of all inventory items, each with a Details link" do
    visit inventory_items_path
    assert_selector "h1", text: "Inventory Items"
    assert_selector "#inventory_items_table"
    assert_link 'Details'
  end

  test "viewing a list of inventory items for a repair" do
    repair = repairs(:one)
    visit repair_path(repair)
    assert_text repair.inventory_items.first.standard_inventory_item.name
  end

  test "viewing a inventory item shows the standard inventory_item name and price" do
    visit inventory_item_path(inventory_items(:one))
    assert_text inventory_items(:one).standard_inventory_item.name
    assert_text inventory_items(:one).price
  end

  test "creating a inventory_item for an repair" do
    visit repair_path(repairs(:one))
    select standard_inventory_items(:one).name, :from => "js-select2"
    fill_in "inventory_item_price", with: standard_inventory_items(:one).price
    click_on "Add Inventory item"
    assert_text "Inventory Item was successfully created"
  end

  test "Adding an invalid inventory_item redisplays the repair view with errors" do
    visit repair_path(repairs(:one))
    click_on 'Add Inventory item'
    assert_text 'prohibited this inventory item from being saved'
  end

  test "updating a inventory_item" do
    visit edit_inventory_item_path(inventory_items(:one))
    fill_in "Price", with: 1000
    click_on "Update Inventory item"
    assert_text "Inventory Item was successfully updated"
  end

  test "updating an invalid inventory_item redisplays the edit view with errors" do
    visit edit_inventory_item_path(inventory_items(:one))
    select '', :from => "js-select2"
    click_on "Update Inventory item"
    assert_text "prohibited this inventory item from being saved"
  end

  test "destroying a inventory_item succeeds" do
    visit inventory_item_path(inventory_items(:one))
    click_on "Delete"
    assert_text "Inventory Item was successfully destroyed"
  end

end