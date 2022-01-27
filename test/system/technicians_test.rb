require "application_system_test_case"

class TechniciansTest < ApplicationSystemTestCase

  include Devise::Test::IntegrationHelpers

  setup do
    @technician = technicians(:one)
    sign_in users(:staff)
  end

  test "visiting the index" do
    visit technicians_path
    assert_selector "h1", text: "Technicians"
  end

  test "creating a Technician" do
    visit technicians_path
    click_on "New Technician"

    fill_in "Name", with: @technician.name
    fill_in "Skill level", with: @technician.skill_level
    click_on "Create Technician"

    assert_text "Technician was successfully created"
    click_on "Back"
  end

  test "updating a Technician" do
    visit technicians_path
    click_on "Edit", match: :first

    fill_in "Name", with: @technician.name
    fill_in "Skill level", with: @technician.skill_level
    click_on "Update Technician"

    assert_text "Technician was successfully updated"
    click_on "Back"
  end

  test "destroying a Technician" do
    skip
    visit technicians_path
    click_on "Destroy", match: :first

    assert_text "Technician was successfully destroyed"
  end
end
