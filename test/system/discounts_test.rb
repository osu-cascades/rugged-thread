require "application_system_test_case"

class DiscountsTest < ApplicationSystemTestCase

  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:staff)
  end

  test "viewing a list of discounts" do
    visit discounts_path
    assert_selector "h1", text: "Discounts"
  end

  test "creating a new discount" do
    visit new_discount_path
    fill_in "Name", with: "Fake Item Name"
    fill_in "Percentage amount", with: 1
    fill_in "Dollar amount", with: 2
    click_on "Save"
    assert_text "Discount was successfully created"
  end

  test "updating a discount" do
    visit edit_discount_path(discounts(:one))
    fill_in "Name", with: 'Updated Fake Name'
    click_on "Save"
    assert_text "Discount was successfully updated"
  end

  test "creating a discount without a name fails" do
    visit new_discount_path
    fill_in "Name", with: ""
    fill_in "Percentage amount", with: 1
    fill_in "Dollar amount", with: 2
    click_on "Save"
    assert_text "Name can't be blank"
  end

  test "creating a duplicate discount fails" do
    visit new_discount_path
    fill_in "Name", with: discounts(:one).name
    fill_in "Percentage amount", with: 1
    fill_in "Dollar amount", with: 2
    click_on "Save"
    assert_text "Name has already been taken"
  end

  test "destroying a discount" do
    visit discounts_path
    click_on "Delete", match: :first
    assert_text "Discount was successfully destroyed"
  end
end
