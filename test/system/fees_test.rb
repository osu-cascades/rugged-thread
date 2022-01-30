require "application_system_test_case"

class FeesTest < ApplicationSystemTestCase

  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:staff)
  end

  test "visiting the index" do
    visit fees_path
    assert_selector "h1", text: "Fees"
  end

  test "creating a Fee" do
    visit new_fee_path
    fill_in "Description", with: "Fake Item Description"
    fill_in "Price", with: 1
    click_on "Create Fee"
    assert_text "Fee was successfully created"
  end

  test "updating a Fee" do
    visit edit_fee_path(fees(:one))
    fill_in "Description", with: 'Updated Fake Description'
    click_on "Update Fee"
    assert_text "Fee was successfully updated"
  end

  test "creating a blank Fee description" do
    visit new_fee_path
    fill_in "Description", with: ""
    fill_in "Price", with: 1
    click_on "Create Fee"
    assert_text "Description can't be blank"
  end

  test "creating a duplicate Fee description" do
    visit new_fee_path
    fill_in "Description", with: fees(:one).description
    fill_in "Price", with: 1
    click_on "Create Fee"
    assert_text "Description has already been taken"
  end

  test "destroying a Fee" do
    visit fees_path
    click_on "Destroy", match: :first
    assert_text "Fee was successfully destroyed"
  end
end
