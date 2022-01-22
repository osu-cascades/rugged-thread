require "application_system_test_case"

class ComplicationTypesTest < ApplicationSystemTestCase

  include Devise::Test::IntegrationHelpers

  setup do
    @complication_type = complication_types(:one)
    sign_in users(:one)
  end

  test "visiting the index" do
    visit complication_types_path
    assert_selector "h1", text: "Complication Types"
  end

  test "creating a Complication type" do
    visit complication_types_path
    click_on "New Complication Type"

    fill_in "Description", with: @complication_type.description
    click_on "Create Complication type"

    assert_text "Complication type was successfully created"
    click_on "Back"
  end

  test "updating a Complication type" do
    visit complication_types_path
    click_on "Edit", match: :first

    fill_in "Description", with: @complication_type.description
    click_on "Update Complication type"

    assert_text "Complication type was successfully updated"
    click_on "Back"
  end

  test "destroying a Complication type" do
    visit complication_types_path
    click_on "Destroy", match: :first
    assert_text "Complication type was successfully destroyed"
  end
end
