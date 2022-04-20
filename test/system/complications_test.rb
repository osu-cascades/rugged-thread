require "application_system_test_case"

class ComplicationsTest < ApplicationSystemTestCase

  include Devise::Test::IntegrationHelpers
  include ActionView::Helpers::NumberHelper

  setup do
    sign_in users(:staff)
  end

  test "visiting the index shows a table of all complications, each with a Details link" do
    visit complications_path
    assert_selector "h1", text: "Complications"
    assert_selector "#complications_table"
    assert_link 'Details'
  end

  test "viewing a list of complications for a repair" do
    repair = repairs(:one)
    visit repair_path(repair)
    assert_text repair.complications.first.standard_complication.name
  end

  test "viewing a complication shows the standard complication name and price" do
    visit complication_path(complications(:one))
    assert_text complications(:one).standard_complication.name
    assert_text number_to_currency(complications(:one).price/100.0)
  end

  test "creating a complication for an repair" do
    visit repair_path(repairs(:one))
    select standard_complications(:one).name, from: :complication_standard_complication_id
    fill_in "complication_price", with: standard_complications(:one).price
    click_on "Add Complication"
    assert_text "Complication was successfully created"
  end

  test "Adding an invalid complication redisplays the repair view with errors" do
    visit repair_path(repairs(:one))
    click_on 'Add Complication'
    assert_text 'prohibited this complication from being saved'
  end

  test "updating a complication" do
    visit edit_complication_path(complications(:one))
    fill_in "Price", with: 1000
    click_on "Update Complication"
    assert_text "Complication was successfully updated"
  end

  test "updating an invalid complication redisplays the edit view with errors" do
    visit edit_complication_path(complications(:one))
    select '', from: :complication_standard_complication_id
    click_on "Update Complication"
    assert_text "prohibited this complication from being saved"
  end

  test "destroying a complication succeeds" do
    visit complication_path(complications(:one))
    click_on "Delete"
    assert_text "Complication was successfully destroyed"
  end

end
