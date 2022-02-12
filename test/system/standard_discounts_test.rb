require "application_system_test_case"

class StandardDiscountsTest < ApplicationSystemTestCase

  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:staff)
  end

  test "viewing a list of standard_discounts" do
    visit standard_discounts_path
    assert_selector "h1", text: "Standard Discounts"
  end

  test "creating a new standard_discount" do
    visit new_standard_discount_path
    fill_in "Name", with: "Fake Item Name"
    fill_in "Percentage amount", with: 1
    fill_in "Dollar amount", with: 2
    click_on "Save"
    assert_text "Standard Discount was successfully created"
  end

  test "updating a standard_discount" do
    visit edit_standard_discount_path(standard_discounts(:one))
    fill_in "Name", with: 'Updated Fake Name'
    click_on "Save"
    assert_text "Standard Discount was successfully updated"
  end

  test "creating a standard_discount without a name fails" do
    visit new_standard_discount_path
    fill_in "Name", with: ""
    fill_in "Percentage amount", with: 1
    fill_in "Dollar amount", with: 2
    click_on "Save"
    assert_text "Name can't be blank"
  end

  test "creating a duplicate standard_discount fails" do
    visit new_standard_discount_path
    fill_in "Name", with: standard_discounts(:one).name
    fill_in "Percentage amount", with: 1
    fill_in "Dollar amount", with: 2
    click_on "Save"
    assert_text "Name has already been taken"
  end

  test "destroying a standard_discount" do
    visit standard_discount_path(standard_discounts(:one))
    click_on 'Delete'
    assert_text "Standard Discount was successfully destroyed"
  end
end
