require "application_system_test_case"

class StandardInventoryItemsTest < ApplicationSystemTestCase

  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:staff)
  end

  test "visiting the index" do
    visit standard_inventory_items_path
    assert_selector "h1", text: "Standard Inventory Items"
  end

  test "creating a standard inventory item" do
    visit new_standard_inventory_item_path
    fill_in "Name", with: 'New Fake Name'
    fill_in "Sku", with: 'New Fake Sku'
    fill_in "Price", with: 1
    click_on "Save"
    assert_text "Standard inventory item was successfully created"
  end

  test "creating a standard inventory item with invalid attributes fails" do
    visit new_standard_inventory_item_path
    fill_in "Name", with: ''
    fill_in "Price", with: 1
    fill_in "Sku", with: 'New Fake SKU'
    click_on "Save"
    assert_text "prohibited this standard inventory item from being saved"
  end

  test "updating a standard inventory item" do
    visit edit_standard_inventory_item_path(standard_inventory_items(:one))
    fill_in "Name", with: 'Updated Name'
    fill_in "Sku", with: 'Updated Sku'
    fill_in "Price", with: 1
    click_on "Save"
    assert_text "Standard inventory item was successfully updated"
  end

  test "updating a standard inventory item with invalid attributes fails" do
    visit edit_standard_inventory_item_path(standard_inventory_items(:one))
    fill_in "Name", with: ''
    fill_in "Sku", with: 'Fake Sku'
    fill_in "Price", with: 1
    click_on "Save"
    assert_text "prohibited this standard inventory item from being saved"
  end

  test "destroying a standard inventory item with no inventory items" do
    visit standard_inventory_item_path(standard_inventory_items(:inventory_itemless))
    click_on 'Delete'
    assert_text "Standard inventory item was successfully destroyed"
  end

  test "failing to destroy a standard inventory item that has inventory items" do
    standard_inventory_item = standard_inventory_items(:one)
    assert_not_empty standard_inventory_item.inventory_items
    visit standard_inventory_item_path(standard_inventory_item)
    click_on 'Delete'
    assert_text "This standard inventory item cannot be deleted, it has inventory items associated with it."
  end

end
