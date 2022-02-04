require "application_system_test_case"

class RepairsTest < ApplicationSystemTestCase

  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:staff)
    @repair = repairs(:one)
  end

  test "visiting the index" do
    visit item_repairs_path(repairs(:one))
    assert_selector "h1", text: "Item "
  end

  test "creating a Repair" do
    visit item_repairs_path
    click_on "Create Repair"

    fill_in "Standard repair", with: @repair.standard_repair_id
    fill_in "Item", with: @repair.item_id
    click_on "Create Repair"

    assert_text "Repair was successfully created"
    click_on "Back"
  end

  test "updating a Repair" do
    visit item_repairs_path(repairs(:one))
    click_on "Details", match: :first
    click_on "Edit", match: :first

    fill_in "Standard repair", with: @repair.standard_repair_id
    fill_in "Item", with: @repair.item_id
    click_on "Update Repair"

    assert_text "Repair was successfully updated"
    click_on "Back"
  end

  test "destroying a Repair" do
    visit item_repairs_path(repairs(:one))
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Repair was successfully destroyed"
  end
end
