require "application_system_test_case"

class RepairsTest < ApplicationSystemTestCase

  include Devise::Test::IntegrationHelpers

  setup do
    @repair = repairs(:one)
    sign_in users(:staff)
  end

  test "visiting the index" do
    visit repairs_path
    assert_selector "h1", text: "Repairs"
  end

  test "creating a Repair" do
    visit repairs_path
    click_on "New Repair"

    fill_in "Charge", with: @repair.charge
    fill_in "Invoice item", with: @repair.invoice_item_id
    fill_in "Repair type", with: @repair.repair_type_id
    fill_in "Technician", with: @repair.technician_id
    fill_in "Time total", with: @repair.time_total
    click_on "Create Repair"

    assert_text "Repair was successfully created"
    click_on "Back"
  end

  test "updating a Repair" do
    visit repairs_path
    click_on "Edit", match: :first

    fill_in "Charge", with: @repair.charge
    fill_in "Invoice item", with: @repair.invoice_item_id
    fill_in "Repair type", with: @repair.repair_type_id
    fill_in "Technician", with: @repair.technician_id
    fill_in "Time total", with: @repair.time_total
    click_on "Update Repair"

    assert_text "Repair was successfully updated"
    click_on "Back"
  end

  test "destroying a Repair" do
    visit repairs_path
    click_on "Destroy", match: :first

    assert_text "Repair was successfully destroyed"
  end
end
