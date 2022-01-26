require "application_system_test_case"

class BrandsTest < ApplicationSystemTestCase

  include Devise::Test::IntegrationHelpers

  setup do
    @brand = brands(:one)
    sign_in users(:staff)
  end

  test "visiting the index" do
    visit brands_path
    assert_selector "h1", text: "Brands"
  end

  test "creating a Brand" do
    visit brands_path
    click_on "New Brand"

    fill_in "Name", with: "Fake Brand"
    click_on "Create Brand"

    assert_text "Brand was successfully created"
    click_on "Back"
  end

  test "updating a Brand" do
    visit brands_path
    click_on "Edit", match: :first

    fill_in "Name", with: @brand.name
    click_on "Update Brand"

    assert_text "Brand was successfully updated"
    click_on "Back"
  end

  test "creating a blank Brand" do
    visit brands_path
    click_on "New Brand"

    fill_in "Name", with: ""
    click_on "Create Brand"

    assert_text "Name can't be blank"
    click_on "Back"
  end

  test "creating a duplicate Brand" do
    visit brands_path
    click_on "New Brand"

    fill_in "Name", with: brands(:two).name
    click_on "Create Brand"

    assert_text "Name has already been taken"
    click_on "Back"
  end

  test "destroying a Brand that has no items" do
    visit brands_path
    dom_id = "#brand_#{brands(:itemless).id}"
    within dom_id do
      click_on "Destroy"
    end
    assert_text "Brand was successfully destroyed"
  end

  # test "failing to destroy a Brand that has items" do
  #   visit brands_path
  #   dom_id = "#brand_#{brands(:one).id}"
  #   within dom_id do
  #     click_on "Destroy"
  #   end
  #   assert_text "Cannot delete this brand"
  # end

end
