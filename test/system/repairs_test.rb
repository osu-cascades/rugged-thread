require "application_system_test_case"

class RepairsTest < ApplicationSystemTestCase
  setup do
    @repair = repairs(:one)
  end

  test "visiting the index" do
    visit repairs_url
    assert_selector "h1", text: "Repairs"
  end

  test "creating a Repair" do
    visit repairs_url
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
    visit repairs_url
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
    visit repairs_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Repair was successfully destroyed"
  end
end
