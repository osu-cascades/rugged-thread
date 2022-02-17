require "application_system_test_case"

class StandardFeesTest < ApplicationSystemTestCase

  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:staff)
  end

  test "viewing a list of standard fees" do
    visit standard_fees_path
    assert_selector "h1", text: "Standard Fees"
  end

  test "creating a new standard fee" do
    visit new_standard_fee_path
    fill_in "Name", with: "Fake Item Name"
    fill_in "Price", with: 1
    click_on "Save"
    assert_text "Standard Fee was successfully created"
  end

  test "updating a standard fee" do
    visit edit_standard_fee_path(standard_fees(:one))
    fill_in "Name", with: 'Updated Fake Name'
    click_on "Save"
    assert_text "Standard Fee was successfully updated"
  end

  test "creating a blank standard fee name" do
    visit new_standard_fee_path
    fill_in "Name", with: ""
    fill_in "Price", with: 1
    click_on "Save"
    assert_text "Name can't be blank"
  end

  test "creating a duplicate standard fee name" do
    visit new_standard_fee_path
    fill_in "Name", with: standard_fees(:one).name
    fill_in "Price", with: 1
    click_on "Save"
    assert_text "Name has already been taken"
  end

  test "destroying a Standard Fee without fees" do
    visit standard_fee_path(standard_fees(:feeless))
    click_on 'Delete'
    assert_text "Standard fee was successfully destroyed"
  end

  test "destroying a Standard Fee that has fees" do
    visit standard_fee_path(standard_fees(:one))
    click_on 'Delete'
    assert_text "Cannot delete this standard fee"
  end

end
