require "application_system_test_case"

class BrandsTest < ApplicationSystemTestCase
  setup do
    @brand = brands(:one)
  end

  test "visiting the index" do
    visit brands_url
    assert_selector "h1", text: "Brands"
  end

  test "creating a Brand" do
    visit brands_url
    click_on "New Brand"

    fill_in "Name", with: @brand.name
    click_on "Create Brand"

    assert_text "Brand was successfully created"
    click_on "Back"
  end

  test "updating a Brand" do
    visit brands_url
    click_on "Edit", match: :first

    fill_in "Name", with: @brand.name
    click_on "Update Brand"

    assert_text "Brand was successfully updated"
    click_on "Back"
  end

  test "destroying a Brand" do
    visit brands_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Brand was successfully destroyed"
  end
end
