require "test_helper"

class QuoteRequestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @quote_request = quote_requests(:one)
  end

  test "should get index" do
    get quote_requests_url
    assert_response :success
  end

  test "should get new" do
    get new_quote_request_url
    assert_response :success
  end

  test "should create quote_request" do
    assert_difference('QuoteRequest.count') do
      post quote_requests_url, params: { quote_request: { brand: @quote_request.brand, description: @quote_request.description, email: @quote_request.email, first_name: @quote_request.first_name, item_type: @quote_request.item_type, last_name: @quote_request.last_name, phone_number: @quote_request.phone_number, promo_code: @quote_request.promo_code, will_mail_item: @quote_request.will_mail_item } }
    end

    assert_redirected_to quote_request_url(QuoteRequest.last)
  end

  test "should show quote_request" do
    get quote_request_url(@quote_request)
    assert_response :success
  end

  test "should get edit" do
    get edit_quote_request_url(@quote_request)
    assert_response :success
  end

  test "should update quote_request" do
    patch quote_request_url(@quote_request), params: { quote_request: { brand: @quote_request.brand, description: @quote_request.description, email: @quote_request.email, first_name: @quote_request.first_name, item_type: @quote_request.item_type, last_name: @quote_request.last_name, phone_number: @quote_request.phone_number, promo_code: @quote_request.promo_code, will_mail_item: @quote_request.will_mail_item } }
    assert_redirected_to quote_request_url(@quote_request)
  end

  test "should destroy quote_request" do
    assert_difference('QuoteRequest.count', -1) do
      delete quote_request_url(@quote_request)
    end

    assert_redirected_to quote_requests_url
  end
end
