require "application_system_test_case"

class RepairsTest < ApplicationSystemTestCase

  include Devise::Test::IntegrationHelpers
  include ActionView::Helpers::NumberHelper

  setup do
    sign_in users(:staff)
  end

  test "visiting the index shows a table of all repairs, each with a Details link" do
    visit repairs_path
    assert_selector "h1", text: "Repairs"
    assert_selector "#repairs_table"
    assert_link 'Details'
  end

  test "viewing a list of repairs for an item" do
    item = items(:one)
    visit item_path(item)
    assert_text item.repairs.first.name
  end

  test "viewing a repair shows the standard repair name, notes, item brand name and item type name" do
    visit repair_path(repairs(:one))
    assert_text repairs(:one).name
    assert_text repairs(:one).notes
    assert_text repairs(:one).level
    assert_text number_to_currency(repairs(:one).price/100.0)
    assert_text repairs(:one).item.brand.name
    assert_text repairs(:one).item.item_type.name
  end

  test "creating a repair for an item" do
    visit item_path(items(:one))
    select standard_repairs(:one).name, from: :repair_standard_repair_id
    fill_in "Notes", with: "Fake repair notes"
    fill_in "repair_price", with: standard_repairs(:one).price
    fill_in "Level", with: '2'
    click_on "Add Repair"
    assert_text "Repair was successfully created"
  end

  test "Adding an invalid repair redisplays the item view with errors" do
    visit item_path(items(:one))
    click_on 'Add Repair'
    assert_text 'prohibited this repair from being saved'
  end

  test "updating a repair" do
    visit edit_repair_path(repairs(:one))
    fill_in "Notes", with: "Fake updated note"
    click_on "Update Repair"
    assert_text "Repair was successfully updated"
  end

  test "updating an invalid repair redisplays the edit view with errors" do
    visit edit_repair_path(repairs(:one))
    select '', from: :repair_standard_repair_id
    click_on "Update Repair"
    assert_text "prohibited this repair from being saved"
  end

  test "destroying a repair without complications succeeds" do
    visit repair_path(repairs(:complicationless))
    click_on "Delete"
    assert_text "Repair was successfully destroyed"
  end

  test "destroying a repair with complications fails" do
    visit repair_path(repairs(:one))
    click_on "Delete"
    assert_text "Cannot delete this repair"
  end

end
