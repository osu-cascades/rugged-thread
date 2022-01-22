require "application_system_test_case"

class ComplicationsTest < ApplicationSystemTestCase

  include Devise::Test::IntegrationHelpers

  setup do
    @complication = complications(:one)
    sign_in users(:one)
  end

  test "visiting the index" do
    visit complications_path
    assert_selector "h1", text: "Complications"
  end

  test "creating a Complication" do
    visit complications_path
    click_on "New Complication"

    fill_in "Charge", with: @complication.charge
    fill_in "Complication type", with: @complication.complication_type_id
    fill_in "Repair", with: @complication.repair_id
    fill_in "Time", with: @complication.time
    click_on "Create Complication"

    assert_text "Complication was successfully created"
    click_on "Back"
  end

  test "updating a Complication" do
    visit complications_path
    click_on "Edit", match: :first

    fill_in "Charge", with: @complication.charge
    fill_in "Complication type", with: @complication.complication_type_id
    fill_in "Repair", with: @complication.repair_id
    fill_in "Time", with: @complication.time
    click_on "Update Complication"

    assert_text "Complication was successfully updated"
    click_on "Back"
  end

  test "destroying a Complication" do
    visit complications_path
    click_on "Destroy", match: :first
    assert_text "Complication was successfully destroyed"
  end
end
