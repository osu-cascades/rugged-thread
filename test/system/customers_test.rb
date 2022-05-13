require "application_system_test_case"

class CustomersTest < ApplicationSystemTestCase

  include Devise::Test::IntegrationHelpers
  include ActionView::RecordIdentifier

  setup do
    sign_in users(:staff)
  end

  test "visiting the index" do
    visit customers_path
    assert_selector "h1", text: "Customers"
  end

  test "only non-archived customers appear in the main list" do
    visit customers_path
    assert_text customers(:one).full_name
    refute_text customers(:archived).full_name
  end

  test "only archived customers appear in the archived list" do
    visit customers_path(show_archive: true)
    refute_text customers(:one).full_name
    assert_text customers(:archived).full_name
  end

  test "creating a Customer" do
    visit new_customer_path
    select customer_types(:one).name, from: 'Customer type'
    fill_in "First name", with: 'Fake'
    fill_in "Last name", with: 'Customer'
    fill_in "Business name", with: 'Fake Business'
    fill_in "Email address", with: 'fake@fake.com'
    fill_in "Phone number", with: '5555555555'
    fill_in "Alternative phone number", with: '5555555556'
    fill_in "customer_shipping_street_address", with: '123 Fake St.'
    fill_in "customer_shipping_city", with: 'Fake City'
    fill_in "customer_shipping_state", with: 'OR'
    fill_in "customer_shipping_zip_code", with: '12345'
    fill_in "customer_billing_street_address", with: '123 Fake St.'
    fill_in "customer_billing_city", with: 'Fake City'
    fill_in "customer_billing_state", with: 'OR'
    fill_in "customer_billing_zip_code", with: '12345'
    click_on "Save"
    assert_text "Customer was successfully created"
  end

  test "creating a Customer with an invalid number fails" do
    visit new_customer_path
    select customer_types(:one).name, from: 'Customer type'
    fill_in "Phone number", with: '88888888888'
    click_on "Save"
    assert_text "Phone number is an invalid number"
  end

  test "updating a Customer" do
    visit edit_customer_path(customers(:one))
    fill_in "Last name", with: 'Updated Fake Last Name'
    click_on "Save"
    assert_text "Customer was successfully updated"
  end

  test "destroying a customer that has no work orders" do
    visit customer_path(customers(:without_work_order))
    click_on 'Delete'
    assert_text "Customer was successfully deleted."
  end

  test "failing to destroy a customer that has work orders" do
    visit customer_path(work_orders.first.customer)
    click_on 'Delete'
    assert_text "This customer cannot be deleted because there are work orders associated with them in the system."
  end

  test "archiving a customer that has work orders succeeds" do
    visit customer_path(work_orders.first.customer)
    click_on 'Archive'
    assert_text "Customer was successfully archived."
  end

  test "recovering a customer succeeds" do
    visit customers_path
    refute_text customers(:archived).first_name
    visit customer_path(customers(:archived))
    click_on 'Recover'
    assert_text 'Customer was successfully recovered.'
  end

  test "Searching for a customer by first name succeeds." do
    visit customers_path(query: customers(:one).first_name)
    assert_text "First Fake"
    refute_text "Second Fake"
  end

  # https://github.com/osu-cascades/rugged-thread/issues/245
  test "customer address appears in list" do
    customer = customers(:one)
    city_state_zip = "#{customer.shipping_city}, #{customer.shipping_state} #{customer.shipping_zip_code}"
    visit customers_path
    within "##{dom_id(customer)}" do
      within 'td.customer_shipping_address' do
        assert_text customer.shipping_street_address
        assert_text city_state_zip
      end
    end
  end

  # https://github.com/osu-cascades/rugged-thread/issues/245
  test "customer address appears in show view" do
    customer = customers(:one)
    city_state_zip = "#{customer.shipping_city}, #{customer.shipping_state} #{customer.shipping_zip_code}"
    visit customer_path(customer)
    assert_text customer.shipping_street_address
    assert_text city_state_zip
  end

  test "customer without a city, state or zip code doesn't appear with only a comma in index" do
    visit customers_path
    within "##{dom_id(customers(:without_an_address))}" do
      within 'td.customer_shipping_address' do
        refute_text ','
      end
    end
  end

  test "customer without a city, state or zip code doesn't appear with only a comma in show" do
    visit customer_path(customers(:without_an_address))
    all('address').each do
      refute_text ','
    end
  end

end
