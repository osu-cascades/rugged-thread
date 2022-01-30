require "application_system_test_case"

class CustomerTypesTest < ApplicationSystemTestCase

  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:staff)
  end

  test "visiting the index" do
    visit customer_types_path
    assert_selector "h1", text: "Customer Types"
  end

  test "creating a Customer type" do
    visit new_customer_type_path
    fill_in "Name", with: "Fake Customer"
    click_on "Save"
    assert_text "Customer type was successfully created"
  end

  test "updating a Customer type" do
    visit edit_customer_type_path(customer_types(:one))
    fill_in "Name", with: 'Updated Customer Type Name'
    click_on "Save"
    assert_text "Customer type was successfully updated"
  end

  test "creating a blank Customer Type" do
    visit new_customer_type_path
    fill_in "Name", with: ""
    click_on "Save"
    assert_text "Name can't be blank"
  end

  test "creating a duplicate Customer Type" do
    visit new_customer_type_path
    fill_in "Name", with: customer_types(:one).name
    click_on "Save"
    assert_text "Name has already been taken"
  end

  test "destroying a Customer type" do
    visit customer_types_path
    click_on "Delete", match: :first
    assert_text "Customer type was successfully destroyed"
  end
end
