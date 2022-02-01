require "application_system_test_case"

class StandardRepairsTest < ApplicationSystemTestCase

  include Devise::Test::IntegrationHelpers

  setup do
    @standard_repair = standard_repairs(:one)
    sign_in users(:staff)
  end

  test "visiting the index" do
    visit standard_repairs_path
    assert_selector "h1", text: "Standard Repairs"
  end

  test "creating a Standard repair" do
    visit standard_repairs_path
    click_on "New Standard Repair"

    fill_in "Charge", with: @standard_repair.charge
    fill_in "Complications", with: @standard_repair.complications
    fill_in "Description", with: @standard_repair.description
    fill_in "Fee type", with: @standard_repair.fee_type
    fill_in "Method", with: @standard_repair.method
    fill_in "Name", with: @standard_repair.name
    fill_in "Sub repair", with: @standard_repair.sub_repair
    click_on "Save"

    assert_text "Standard repair was successfully created"
  end

  test "updating a Standard repair" do
    visit standard_repairs_path
    click_on "Edit", match: :first

    fill_in "Charge", with: @standard_repair.charge
    fill_in "Complications", with: @standard_repair.complications
    fill_in "Description", with: @standard_repair.description
    fill_in "Fee type", with: @standard_repair.fee_type
    fill_in "Method", with: @standard_repair.method
    fill_in "Name", with: @standard_repair.name
    fill_in "Sub repair", with: @standard_repair.sub_repair
    click_on "Save"

    assert_text "Standard repair was successfully updated"
  end

  test "destroying a Standard repair" do
    visit standard_repairs_path
    click_on "Delete", match: :first

    assert_text "Standard repair was successfully destroyed"
  end
end
