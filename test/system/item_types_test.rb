require "application_system_test_case"

class ItemTypesTest < ApplicationSystemTestCase
  setup do
    @item_type = item_types(:one)
  end

  test "visiting the index" do
    visit item_types_url
    assert_selector "h1", text: "Item Types"
  end

  test "creating a Item type" do
    visit item_types_url
    click_on "New Item Type"

    fill_in "Component", with: @item_type.component
    fill_in "Name", with: @item_type.name
    click_on "Create Item type"

    assert_text "Item type was successfully created"
    click_on "Back"
  end

  test "updating a Item type" do
    visit item_types_url
    click_on "Edit", match: :first

    fill_in "Component", with: @item_type.component
    fill_in "Name", with: @item_type.name
    click_on "Update Item type"

    assert_text "Item type was successfully updated"
    click_on "Back"
  end

  test "destroying a Item type" do
    visit item_types_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Item type was successfully destroyed"
  end
end
