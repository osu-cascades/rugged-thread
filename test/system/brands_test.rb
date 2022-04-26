require "application_system_test_case"

class BrandsTest < ApplicationSystemTestCase

  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:staff)
  end

  test "visiting the index" do
    visit brands_path
    assert_selector "h1", text: "Brands"
  end

  test "creating a Brand" do
    visit new_brand_path
    fill_in "Name", with: "Fake Brand"
    click_on "Save"

    assert_text "Brand was successfully created"
  end

  test "updating a Brand" do
    visit edit_brand_path(brands(:one))

    fill_in "Name", with: 'Updated Fake Brand'
    click_on "Save"

    assert_text "Brand was successfully updated"
  end

  test "creating a blank Brand" do
    visit new_brand_path
    fill_in "Name", with: ""
    click_on "Save"
    assert_text "Name can't be blank"
  end

  test "creating a duplicate Brand" do
    visit new_brand_path
    fill_in "Name", with: brands(:one).name
    click_on "Save"
    assert_text "Name has already been taken"
  end

  test "destroying a Brand that has no items" do
    visit brand_path(brands(:itemless))
    click_on 'Delete'
    assert_text "Brand was successfully destroyed"
  end

  test "failing to destroy a Brand that has items" do
    visit brand_path(brands(:one))
    click_on 'Delete'
    assert_text "Cannot delete this brand"
  end

  test "archiving a brand succeeds" do
    visit brand_path(brands(:one))
    click_on 'Archive'
    assert_text "Brand was successfully archived."
  end

  test "recovering a brand succeeds" do
    skip
  end

end
