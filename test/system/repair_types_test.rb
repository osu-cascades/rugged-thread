require "application_system_test_case"

class RepairTypesTest < ApplicationSystemTestCase

  include Devise::Test::IntegrationHelpers

  setup do
    @repair_type = repair_types(:one)
    sign_in users(:staff)
  end

  test "visiting the index" do
    visit repair_types_path
    assert_selector "h1", text: "Repair Types"
  end

  test "creating a Repair type" do
    visit repair_types_path
    click_on "New Repair Type"

    fill_in "Name", with: @repair_type.name
    fill_in "Time estimate", with: @repair_type.time_estimate
    click_on "Create Repair type"

    assert_text "Repair type was successfully created"
    click_on "Back"
  end

  test "updating a Repair type" do
    visit repair_types_path
    click_on "Edit", match: :first

    fill_in "Name", with: @repair_type.name
    fill_in "Time estimate", with: @repair_type.time_estimate
    click_on "Update Repair type"

    assert_text "Repair type was successfully updated"
    click_on "Back"
  end

  # test "destroying a Repair type" do
  #   visit repair_types_path
  #   click_on "Destroy", match: :first

  #   assert_text "Repair type was successfully destroyed"
  # end
end
