require "application_system_test_case"

class QuoteRequestsTest < ApplicationSystemTestCase

  include Devise::Test::IntegrationHelpers

  setup do
    @quote_request = quote_requests(:one)
    sign_in users(:staff)
  end

  test "visiting the index" do
    visit quote_requests_path
    assert_selector "h1", text: "Quote Requests"
  end

  test "creating a Quote request" do
    visit quote_requests_path
    click_on "New Quote Request"

    fill_in "Brand", with: @quote_request.brand
    fill_in "Description", with: @quote_request.description
    fill_in "Email", with: @quote_request.email
    fill_in "First name", with: @quote_request.first_name
    fill_in "Item type", with: @quote_request.item_type
    fill_in "Last name", with: @quote_request.last_name
    fill_in "Phone number", with: @quote_request.phone_number
    fill_in "Promo code", with: @quote_request.promo_code
    fill_in "Will mail item", with: @quote_request.will_mail_item
    click_on "Create Quote request"

    assert_text "Quote request was successfully created"
    click_on "Back"
  end

  test "updating a Quote request" do
    visit quote_requests_path
    click_on "Edit", match: :first

    fill_in "Brand", with: @quote_request.brand
    fill_in "Description", with: @quote_request.description
    fill_in "Email", with: @quote_request.email
    fill_in "First name", with: @quote_request.first_name
    fill_in "Item type", with: @quote_request.item_type
    fill_in "Last name", with: @quote_request.last_name
    fill_in "Phone number", with: @quote_request.phone_number
    fill_in "Promo code", with: @quote_request.promo_code
    fill_in "Will mail item", with: @quote_request.will_mail_item
    click_on "Update Quote request"

    assert_text "Quote request was successfully updated"
    click_on "Back"
  end

  test "destroying a Quote request" do
    visit quote_requests_path
    click_on "Destroy", match: :first

    assert_text "Quote request was successfully destroyed"
  end
end
