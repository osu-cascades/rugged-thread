require "application_system_test_case"

class StandardRepairsTest < ApplicationSystemTestCase

  include Devise::Test::IntegrationHelpers

  setup do
    @standard_repair = standard_repairs(:standard)
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
    fill_in "Description", with: @standard_repair.description
    fill_in "Method", with: @standard_repair.method
    fill_in "Name", with: @standard_repair.name
    click_on "Save"

    assert_text "Standard repair was successfully created"
  end

  test "updating a Standard repair" do
    visit edit_standard_repair_path(@standard_repair)
    fill_in "Charge", with: @standard_repair.charge
    fill_in "Description", with: @standard_repair.description
    fill_in "Method", with: @standard_repair.method
    fill_in "Name", with: @standard_repair.name
    click_on "Save"

    assert_text "Standard repair was successfully updated"
  end

  test "destroying a Standard repair with no repairs" do
    skip
    visit standard_repair_path(standard_repairs(:repairless))
    click_on 'Delete'
    assert_text "Standard repair was successfully destroyed"
  end

  test "failing to destroy a standard repair that has repairs" do
    skip
    visit standard_repair_path(standard_repairs(:standard))
    click_on 'Delete'
    assert_text "Cannot delete this standard repair"
  end

end
