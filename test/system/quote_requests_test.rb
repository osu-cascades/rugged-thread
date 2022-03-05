require "application_system_test_case"

class QuoteRequestsTest < ApplicationSystemTestCase

  include Devise::Test::IntegrationHelpers

  # Non-logged-in users.

  test "creating a quote request" do

    visit new_quote_request_path
    fill_in "First name", with: 'FAKE FIRST'
    fill_in "Last name", with: 'FAKE LAST'
    fill_in "Email", with: 'fake@fake.com'
    fill_in "Phone number", with: '5415555555'
    select item_types.first.name, from: 'quote_request_item_type_id'
    select brands.first.name, from: 'quote_request_brand_id'
    fill_in "Description", with: 'Fake quote request description.'
    skip # https://stackoverflow.com/questions/71366018/rails-system-test-w-capybara-racktest-raises-system-test-raises-activesupport
    click_on "Send this quote request"
    assert_text "Thank you! Your quote request has been received."
    assert_text "Your Repair Quote Request"
  end

end
