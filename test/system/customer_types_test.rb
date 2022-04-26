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
    fill_in "Turn around", with: "21"
    click_on "Save"
    assert_text "Customer type was successfully created"
  end

  test "updating a Customer type" do
    visit edit_customer_type_path(customer_types(:one))
    fill_in "Name", with: 'Updated Customer Type Name'
    click_on "Save"
    assert_text "Customer type was successfully updated"
  end

  test "creating an unnamed Customer Type fails" do
    visit new_customer_type_path
    fill_in "Name", with: ""
    fill_in "Turn around", with: ""
    click_on "Save"
    assert_text "Name can't be blank"
    assert_text "Turn around can't be blank"
  end

  test "creating a duplicate Customer Type" do
    visit new_customer_type_path
    fill_in "Name", with: customer_types(:one).name
    click_on "Save"
    assert_text "Name has already been taken"
  end

  test "destroying a customer type that has no customers" do
    visit customer_type_path(customer_types(:customerless))
    click_on 'Delete'
    assert_text "Customer type was successfully destroyed"
  end

  test "failing to destroy a customer type that has customers" do
    visit customer_type_path(customers.first.customer_type)
    click_on 'Delete'
    assert_text "Cannot delete this customer type"
  end

  test "archiving a customer type succeeds" do
    visit customer_type_path(customer_types(:one))
    click_on 'Archive'
    assert_text "Customer type was successfully archived."
  end

  test "recovering a customer type succeeds" do
    skip
  end

end
