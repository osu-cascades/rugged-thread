require "application_system_test_case"

class StandardComplicationsTest < ApplicationSystemTestCase

  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:staff)
  end

  test "visiting the index" do
    visit standard_complications_path
    assert_selector "h1", text: "Standard Complications"
  end

  test "creating a standard complication" do
    visit new_standard_complication_path
    select standard_repairs.first.name, from: 'Standard repair'
    fill_in "Name", with: 'New Fake Name'
    fill_in "Price", with: 1
    click_on "Save"
    assert_text "Standard complication was successfully created"
  end

  test "creating a standard complication in the context of a standard repair" do
    standard_repair = standard_repairs.first
    visit new_standard_repair_standard_complication_path(standard_repair)
    assert_select 'Standard repair', with_selected: standard_repair.name
    fill_in "Name", with: 'New Fake Name'
    click_on "Save"
    assert_text "Standard complication was successfully created"
  end

  test "creating a standard complication with invalid attributes fails" do
    visit new_standard_complication_path
    fill_in "Name", with: ''
    click_on "Save"
    assert_text "prohibited this standard complication from being saved"
  end

  test "updating a standard complication" do
    visit edit_standard_complication_path(standard_complications(:one))
    fill_in "Name", with: 'Updated Name'
    click_on "Save"
    assert_text "Standard complication was successfully updated"
    assert_text "Updated Name"
  end

  test "updating a standard complication with invalid attributes fails" do
    visit edit_standard_complication_path(standard_complications(:one))
    fill_in "Name", with: ''
    click_on "Save"
    assert_text "prohibited this standard complication from being saved"
  end

  test "destroying a standard complication with no complications" do
    visit standard_complication_path(standard_complications(:complicationless))
    click_on 'Delete'
    assert_text "Standard complication was successfully destroyed"
  end

  test "failing to destroy a standard complication that has complications" do
    standard_complication = standard_complications(:one)
    assert_not_empty standard_complication.complications
    visit standard_complication_path(standard_complication)
    click_on 'Delete'
    assert_text "Cannot delete this standard complication"
  end

end
