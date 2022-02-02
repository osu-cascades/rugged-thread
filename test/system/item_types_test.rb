require "application_system_test_case"

class ItemTypesTest < ApplicationSystemTestCase

  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:staff)
  end

  test "visiting the index" do
    visit item_types_path
    assert_selector "h1", text: "Item Types"
  end

  test "creating a Item type" do
    visit new_item_type_path
    fill_in "Name", with: "Fake Item Type"
    click_on "Save"
    assert_text "Item type was successfully created"
  end

  test "updating a Item type" do
    visit edit_item_type_path(item_types(:one))
    fill_in "Name", with: "Updated Fake Item Type"
    click_on "Save"
    assert_text "Item type was successfully updated"
  end

  test "creating an item type with a blank name fails" do
    visit new_item_type_path
    fill_in "Name", with: ""
    click_on "Save"
    assert_text "Name can't be blank"
  end

  test "creating an item type with a duplicate name fails" do
    visit new_item_type_path
    fill_in "Name", with: item_types(:one).name
    click_on "Save"
    assert_text "Name has already been taken"
  end

  test "destroying a item type that has no items" do
    visit item_type_path(item_types(:itemless))
    click_on 'Delete'
    assert_text "Item type was successfully destroyed"
  end

  test "failing to destroy a item type that has items" do
    visit item_type_path(item_types(:one))
    click_on 'Delete'
    assert_text "Cannot delete this item type"
  end

end
