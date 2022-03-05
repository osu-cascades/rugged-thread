require "test_helper"

class QuoteRequestTest < ActiveSupport::TestCase

  test "attributes" do
    assert_respond_to(QuoteRequest.new, :first_name)
    assert_respond_to(QuoteRequest.new, :last_name)
    assert_respond_to(QuoteRequest.new, :email)
    assert_respond_to(QuoteRequest.new, :phone_number)
    assert_respond_to(QuoteRequest.new, :promo_code)
    assert_respond_to(QuoteRequest.new, :description)
    assert_respond_to(QuoteRequest.new, :shipping)
    assert_respond_to(QuoteRequest.new, :status)
  end

  test "associations" do
    assert_respond_to(QuoteRequest.new, :item_type)
    assert_respond_to(QuoteRequest.new, :brand)
    assert_respond_to(QuoteRequest.new, :photos)
  end

  test "cannot be deleted if..." do

  end

  test "is not valid without a first name" do
    quote_request = quote_requests(:fresh)
    assert quote_request.valid?
    quote_request.first_name = ''
    refute quote_request.valid?
  end

  test "is not valid without a last name" do
    quote_request = quote_requests(:fresh)
    assert quote_request.valid?
    quote_request.last_name = ''
    refute quote_request.valid?
  end

    test "is not valid without a email" do
    quote_request = quote_requests(:fresh)
    assert quote_request.valid?
    quote_request.email = ''
    refute quote_request.valid?
  end

    test "is not valid without a phone number" do
    quote_request = quote_requests(:fresh)
    assert quote_request.valid?
    quote_request.phone_number = ''
    refute quote_request.valid?
  end

  test "is not valid without a description" do
    quote_request = quote_requests(:fresh)
    assert quote_request.valid?
    quote_request.description = ''
    refute quote_request.valid?
  end

  test "is not valid without a status" do
    quote_request = quote_requests(:fresh)
    assert quote_request.valid?
    quote_request.status = nil
    refute quote_request.valid?
  end

  test "#to_s string representation is..." do

  end

end
