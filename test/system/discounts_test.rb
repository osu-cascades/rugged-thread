require "application_system_test_case"

class DiscountsTest < ApplicationSystemTestCase

  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:staff)
  end

  test "visiting the index" do
    visit discounts_path
    assert_selector "h1", text: "Discounts"
  end

  test "creating a Discount" do
    visit new_discount_path
    fill_in "Description", with: "Fake Item Description"
    fill_in "Percentage amount", with: 1
    fill_in "Dollar amount", with: 2
    click_on "Save"
    assert_text "Discount was successfully created"
  end

  test "updating a Discount" do
    visit edit_discount_path(discounts(:one))
    fill_in "Description", with: 'Updated Fake Description'
    click_on "Save"
    assert_text "Discount was successfully updated"
  end

  test "creating a blank Discount description" do
    visit new_discount_path
    fill_in "Description", with: ""
    fill_in "Percentage amount", with: 1
    fill_in "Dollar amount", with: 2
    click_on "Save"
    assert_text "Description can't be blank"
  end

  test "creating a duplicate Discount description" do
    visit new_discount_path
    fill_in "Description", with: discounts(:one).description
    fill_in "Percentage amount", with: 1
    fill_in "Dollar amount", with: 2
    click_on "Save"
    assert_text "Description has already been taken"
  end

  test "destroying a Discount" do
    visit discounts_path
    click_on "Delete", match: :first
    assert_text "Discount was successfully destroyed"
  end
end
