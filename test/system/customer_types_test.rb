require "application_system_test_case"

class CustomerTypesTest < ApplicationSystemTestCase
  setup do
    @customer_type = customer_types(:one)
  end

  test "visiting the index" do
    visit customer_types_url
    assert_selector "h1", text: "Customer Types"
  end

  test "creating a Customer type" do
    visit customer_types_url
    click_on "New Customer Type"

    click_on "Create Customer type"

    assert_text "Customer type was successfully created"
    click_on "Back"
  end

  test "updating a Customer type" do
    visit customer_types_url
    click_on "Edit", match: :first

    click_on "Update Customer type"

    assert_text "Customer type was successfully updated"
    click_on "Back"
  end

  test "destroying a Customer type" do
    visit customer_types_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Customer type was successfully destroyed"
  end
end
