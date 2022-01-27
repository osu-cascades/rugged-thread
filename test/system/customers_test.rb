require "application_system_test_case"

class CustomersTest < ApplicationSystemTestCase

  include Devise::Test::IntegrationHelpers
  
  setup do
    @customer = customers(:one)
    sign_in users(:staff)
  end

  test "visiting the index" do
    visit customers_path
    assert_selector "h1", text: "Customers"
  end

  test "creating a Customer" do
    visit customers_path
    click_on "New Customer"

    fill_in "Business name", with: @customer.business_name
    fill_in "City", with: @customer.city
    fill_in "Email address", with: @customer.email_address
    fill_in "First name", with: @customer.first_name
    fill_in "Last name", with: @customer.last_name
    fill_in "Phone number", with: @customer.phone_number
    fill_in "State", with: @customer.state
    fill_in "Street address", with: @customer.street_address
    fill_in "Zip code", with: @customer.zip_code
    click_on "Save"

    assert_text "Customer was successfully created"
    click_on "Back"
  end

  test "updating a Customer" do
    visit customers_path
    click_on "Edit", match: :first

    fill_in "Business name", with: @customer.business_name
    fill_in "City", with: @customer.city
    fill_in "Email address", with: @customer.email_address
    fill_in "First name", with: @customer.first_name
    fill_in "Last name", with: @customer.last_name
    fill_in "Phone number", with: @customer.phone_number
    fill_in "State", with: @customer.state
    fill_in "Street address", with: @customer.street_address
    fill_in "Zip code", with: @customer.zip_code
    click_on "Save"

    assert_text "Customer was successfully updated"
    click_on "Back"
  end

  test "destroying a Customer" do
    skip
    visit customers_path
    click_on "Destroy", match: :first

    assert_text "Customer was successfully destroyed"
  end
end
