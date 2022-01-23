require "application_system_test_case"

class FeesTest < ApplicationSystemTestCase

  include Devise::Test::IntegrationHelpers

  setup do
    @fee = fees(:one)
    sign_in users(:staff)
  end

  test "visiting the index" do
    visit fees_path
    assert_selector "h1", text: "Fees"
  end

  test "creating a Fee" do
    visit fees_path
    click_on "New Fee"

    fill_in "Description", with: "Fake Item Description"
    fill_in "Price", with: @fee.price

    click_on "Create Fee"

    assert_text "Fee was successfully created"
    click_on "Back"
  end

  test "updating a Fee" do
    visit fees_path
    click_on "Edit", match: :first

    fill_in "Description", with: @fee.description
    fill_in "Price", with: @fee.price

    click_on "Update Fee"

    assert_text "Fee was successfully updated"
    click_on "Back"
  end

  test "creating a blank Fee description" do
    visit fees_path
    click_on "New Fee"

    fill_in "Description", with: ""
    fill_in "Price", with: @fee.price

    click_on "Create Fee"

    assert_text "Description can't be blank"
    click_on "Back"
  end

  test "creating a duplicate Fee description" do
    visit fees_path
    click_on "New Fee"

    fill_in "Description", with: @fee.description
    fill_in "Price", with: @fee.price

    click_on "Create Fee"

    assert_text "Description has already been taken"
    click_on "Back"
  end

  test "creating a non-integer Fee price" do
    visit fees_path
    click_on "New Fee"

    fill_in "Description", with: @fee.description
    fill_in "Price", with: "abcdefg"

    click_on "Create Fee"

    assert_text "Price is not a number"
    click_on "Back"
  end

  test "destroying a Fee" do
    visit fees_path
    click_on "Destroy", match: :first

    assert_text "Fee was successfully destroyed"
  end
end
