require "application_system_test_case"

class StandardRepairsTest < ApplicationSystemTestCase

  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:staff)
  end

  test "visiting the index" do
    visit standard_repairs_path
    assert_selector "h1", text: "Standard Repairs"
  end

  test "viewing a standard repair lists the associated standard complications" do
    standard_complication = standard_complications.first
    standard_repair = standard_complication.standard_repair
    visit standard_repair_path(standard_repair)
    assert_text standard_repair.name
    within 'table' do
      assert_text standard_complication.name
    end
  end

  test "creating a standard repair" do
    visit new_standard_repair_path
    fill_in "Name", with: 'New Fake Name'
    fill_in "Description", with: 'New fake description'
    fill_in "Method", with: 'New fake method'
    fill_in "Price", with: 1
    click_on "Save"
    assert_text "Standard repair was successfully created"
  end

  test "creating a standard repair with an existing name but different method succeeds" do
    visit new_standard_repair_path
    fill_in "Name", with: standard_repairs.first.name
    fill_in "Description", with: 'New fake description'
    fill_in "Method", with: 'New fake method'
    fill_in "Price", with: 1
    click_on "Save"
    assert_text "Standard repair was successfully created"
  end

  test "creating a standard repair with an existing name and method fails" do
    visit new_standard_repair_path
    fill_in "Name", with: standard_repairs.first.name
    fill_in "Description", with: 'New fake description'
    fill_in "Method", with: standard_repairs.first.method
    fill_in "Price", with: 1
    click_on "Save"
    assert_text "prohibited this standard repair from being saved"
  end

  test "creating a standard repair with invalid attributes fails" do
    visit new_standard_repair_path
    fill_in "Name", with: ''
    click_on "Save"
    assert_text "prohibited this standard repair from being saved"
  end

  test "updating a standard repair" do
    visit edit_standard_repair_path(standard_repairs(:one))
    fill_in "Name", with: 'Updated Name'
    click_on "Save"
    assert_text "Standard repair was successfully updated"
    assert_text "Updated Name"
  end

  test "updating a standard repair with invalid attributes fails" do
    visit edit_standard_repair_path(standard_repairs(:one))
    fill_in "Name", with: ''
    click_on "Save"
    assert_text "prohibited this standard repair from being saved"
  end

  test "destroying a standard repair with no repairs" do
    visit standard_repair_path(standard_repairs(:repairless))
    click_on 'Delete'
    assert_text "Standard repair was successfully destroyed"
  end

  test "failing to destroy a standard repair that has repairs" do
    visit standard_repair_path(standard_repairs(:one))
    click_on 'Delete'
    assert_text "This standard repair cannot be deleted, it hass repairs associated with it."
  end

  test "archiving a standard repair succeeds" do
    visit standard_repair_path(standard_repairs(:one))
    click_on 'Archive'
    assert_text "Standard Repair was successfully archived."
  end

  test "recovering a standard repair succeeds" do
    visit standard_repairs_path
    refute_text standard_repairs(:archived).name
    visit standard_repair_path(standard_repairs(:archived))
    click_on 'Recover'
    assert_text 'Standard Repair was successfully recovered.'
  end
end
