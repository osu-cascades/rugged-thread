require "application_system_test_case"

class RepairsTest < ApplicationSystemTestCase

  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:staff)
    @repair = repairs(:one)
  end

  test "visiting the index" do
    visit item_path(repairs(:one))
    assert_selector "h1", text: "Item "
  end

  test "creating a Repair" do
    visit item_path(repairs(:one))
    click_on "Create Repair"

    select standard_repairs(:standard).name, from: :repair_standard_repair_id
    click_on "Create Repair"

    assert_text "Repair was successfully created"
  end

  test "updating a Repair" do
    visit item_path(repairs(:one))
    click_on "Details", match: :first
    click_on "Edit", match: :first

    select standard_repairs(:standard).name, from: :repair_standard_repair_id
    click_on "Update Repair"

    assert_text "Repair was successfully updated"
  end

  test "destroying a Repair" do
    visit item_path(repairs(:one))
    click_on "Details", match: :first
    click_on "Delete", match: :first

    assert_text "Repair was successfully destroyed"
  end
end
