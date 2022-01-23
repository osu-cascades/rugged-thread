require "application_system_test_case"

class DiscountsTest < ApplicationSystemTestCase

  include Devise::Test::IntegrationHelpers

  setup do
    @discount = discounts(:one)
    sign_in users(:staff)
  end

  test "visiting the index" do
    visit discounts_path
    assert_selector "h1", text: "Discounts"
  end

  test "creating a Discount" do
    visit discounts_path
    click_on "New Discount"

    fill_in "Description", with: "Fake Item Description"
    fill_in "Percentage amount", with: @discount.percentage_amount
    fill_in "Dollar amount", with: @discount.dollar_amount
    click_on "Create Discount"

    assert_text "Discount was successfully created"
    click_on "Back"
  end

  test "updating a Discount" do
    visit discounts_path
    click_on "Edit", match: :first

    fill_in "Description", with: @discount.description
    fill_in "Percentage amount", with: @discount.percentage_amount
    fill_in "Dollar amount", with: @discount.dollar_amount
    click_on "Update Discount"

    assert_text "Discount was successfully updated"
    click_on "Back"
  end

  test "creating a blank Discount description" do
    visit discounts_path
    click_on "New Discount"

    fill_in "Description", with: ""
    fill_in "Percentage amount", with: @discount.percentage_amount
    fill_in "Dollar amount", with: @discount.dollar_amount

    click_on "Create Discount"

    assert_text "Description can't be blank"
    click_on "Back"
  end

  test "creating a duplicate Discount description" do
    visit discounts_path
    click_on "New Discount"

    fill_in "Description", with: @discount.description
    fill_in "Percentage amount", with: @discount.percentage_amount
    fill_in "Dollar amount", with: @discount.dollar_amount

    click_on "Create Discount"

    assert_text "Description has already been taken"
    click_on "Back"
  end


  test "creating a non-integer Percentage Amount price" do
    visit discounts_path
    click_on "New Discount"

    fill_in "Description", with: "Fake Description for Percentage non-integer test"
    fill_in "Percentage amount", with: "Fake Percentage"
    fill_in "Dollar amount", with: @discount.dollar_amount

    click_on "Create Discount"

    assert_text "Percentage amount is not a number"
    click_on "Back"
  end

  test "creating a non-integer Dollar Amount price" do
    visit discounts_path
    click_on "New Discount"

    fill_in "Description", with: "Fake Description for  Dollar non-integer test"
    fill_in "Percentage amount", with: @discount.percentage_amount
    fill_in "Dollar amount", with: "Fake Dollar"

    click_on "Create Discount"

    assert_text "Dollar amount is not a number"
    click_on "Back"
  end

  test "creating a float Percentage Amount price" do
    visit discounts_path
    click_on "New Discount"

    fill_in "Description", with: "Fake Description for Percentage float test"
    fill_in "Percentage amount", with: 20.5
    fill_in "Dollar amount", with: @discount.dollar_amount

    click_on "Create Discount"

    assert_text "Percentage amount must be an integer"
    click_on "Back"
  end

  test "creating a float Dollar Amount price" do
    visit discounts_path
    click_on "New Discount"

    fill_in "Description", with: "Fake Description for  Dollar float test"
    fill_in "Percentage amount", with: @discount.percentage_amount
    fill_in "Dollar amount", with: 19.8

    click_on "Create Discount"

    assert_text "Dollar amount must be an integer"
    click_on "Back"
  end

  test "destroying a Discount" do
    visit discounts_path
    click_on "Destroy", match: :first

    assert_text "Discount was successfully destroyed"
  end
end
