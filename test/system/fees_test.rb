require "application_system_test_case"

class FeesTest < ApplicationSystemTestCase

  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:staff)
  end

  test "viewing a list of fees" do
    visit fees_path
    assert_selector "h1", text: "Fees"
  end

  test "creating a new fee" do
    visit new_fee_path
    fill_in "Name", with: "Fake Item Name"
    fill_in "Price", with: 1
    click_on "Save"
    assert_text "Fee was successfully created"
  end

  test "updating a fee" do
    visit edit_fee_path(fees(:one))
    fill_in "Name", with: 'Updated Fake Name'
    click_on "Save"
    assert_text "Fee was successfully updated"
  end

  test "creating a blank fee name" do
    visit new_fee_path
    fill_in "Name", with: ""
    fill_in "Price", with: 1
    click_on "Save"
    assert_text "Name can't be blank"
  end

  test "creating a duplicate fee name" do
    visit new_fee_path
    fill_in "Name", with: fees(:one).name
    fill_in "Price", with: 1
    click_on "Save"
    assert_text "Name has already been taken"
  end

  test "destroying a Fee" do
    visit fee_path(fees(:one))
    click_on 'Delete'
    assert_text "Fee was successfully destroyed"
  end
end
