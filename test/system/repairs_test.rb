require "application_system_test_case"

class RepairsTest < ApplicationSystemTestCase

  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:staff)
  end

  test "viewing a list of repairs for an item" do
    item = items(:one)
    visit item_path(item)
    assert_text item.repairs.first.standard_repair.name
  end

  test "viewing a repair shows the standard repair name, item brand name and item type name" do
    visit repair_path(repairs(:one))
    assert_text repairs(:one).standard_repair.name
    assert_text repairs(:one).item.brand.name
    assert_text repairs(:one).item.item_type.name
  end

  test "creating a repair" do
    visit item_path(items(:one))
    select standard_repairs(:one).name, from: :repair_standard_repair_id
    click_on "Create Repair"
    assert_text "Repair was successfully created"
  end

  test "updating a Repair" do
    visit edit_repair_path(repairs(:one))
    select standard_repairs(:repairless).name, from: :repair_standard_repair_id
    click_on "Update Repair"
    assert_text "Repair was successfully updated"
  end

  test "destroying a Repair" do
    visit repair_path(repairs(:one))
    click_on "Delete"
    assert_text "Repair was successfully destroyed"
  end

end
