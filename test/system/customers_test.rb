require "application_system_test_case"

class CustomersTest < ApplicationSystemTestCase

  include Devise::Test::IntegrationHelpers
  
  setup do
    sign_in users(:staff)
  end

  test "visiting the index" do
    visit customers_path
    assert_selector "h1", text: "Customers"
  end

  test "creating a Customer" do
    visit new_customer_path
    fill_in "Business name", with: 'Fake Business'
    fill_in "City", with: 'Fake City'
    fill_in "Email address", with: 'fake@fake.com'
    fill_in "First name", with: 'Fake'
    fill_in "Last name", with: 'Customer'
    fill_in "Phone number", with: '5555555555'
    fill_in "State", with: 'OR'
    fill_in "Street address", with: '123 Fake St.'
    fill_in "Zip code", with: '12345'
    click_on "Save"
    assert_text "Customer was successfully created"
  end

  test "updating a Customer" do
    visit edit_customer_path(customers(:one))
    fill_in "Last name", with: 'Updated Fake Last Name'
    click_on "Save"
    assert_text "Customer was successfully updated"
  end

  test "destroying a customer that has no work orders" do
    visit customers_path
    dom_id = "#customer_#{customers(:without_work_order).id}"
    within(dom_id) { click_on "Delete" }
    assert_text "Customer was successfully destroyed"
  end

  test "failing to destroy a customer that has work orders" do
    visit customers_path
    dom_id = "#customer_#{customers(:one).id}"
    within(dom_id) { click_on "Delete" }
    assert_text "Cannot delete this customer"
  end

end
