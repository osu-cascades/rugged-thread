require "application_system_test_case"

class ItemTypesTest < ApplicationSystemTestCase

  include Devise::Test::IntegrationHelpers

  setup do
    @item_type = item_types(:one)
    sign_in users(:staff)
  end

  test "visiting the index" do
    visit item_types_path
    assert_selector "h1", text: "Item Types"
  end

  test "creating a Item type" do
    visit item_types_path
    click_on "New Item Type"
    fill_in "Name", with: "Fake Item Type"
    click_on "Create Item type"

    assert_text "Item type was successfully created"
    click_on "Back"
  end

  test "updating a Item type" do
    visit item_types_path
    click_on "Edit", match: :first
    fill_in "Name", with: @item_type.name
    click_on "Update Item type"

    assert_text "Item type was successfully updated"
    click_on "Back"
  end

  test "creating a blank Item type name" do
    visit item_types_path
    click_on "New Item Type"

    fill_in "Name", with: ""

    click_on "Create Item type"

    assert_text "Name can't be blank"
    click_on "Back"
  end

  test "creating a duplicate Item type name" do
    visit item_types_path
    click_on "New Item Type"

    fill_in "Name", with: @item_type.name

    click_on "Create Item type"

    assert_text "Name has already been taken"
    click_on "Back"
  end

  test "destroying a Item type" do
    visit item_types_path
    click_on "Destroy", match: :first

    assert_text "Item type was successfully destroyed"
  end
end
