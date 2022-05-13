require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase

  # present_address_city_state_zip

  test 'returns city, state zip when all are present' do
    customer = customers(:one)
    assert_equal(
      present_address_city_state_zip(
        customer.shipping_city, customer.shipping_state, customer.shipping_zip_code),
      "#{customer.shipping_city}, #{customer.shipping_state} #{customer.shipping_zip_code}"
    )
  end

  test 'returns zip code if city and state are blank' do
    customer = customers(:one)
    customer.shipping_city = ""
    customer.shipping_state = ""
    assert_equal(present_address_city_state_zip(customer.shipping_city, customer.shipping_state, customer.shipping_zip_code), customer.shipping_zip_code) 
  end

  test 'returns state and zip code if city is blank' do
    customer = customers(:one)
    customer.shipping_city = ""
    assert_equal(present_address_city_state_zip(customer.shipping_city, customer.shipping_state, customer.shipping_zip_code), "#{customer.shipping_state} #{customer.shipping_zip_code}")
  end

  test 'returns city and zip code if state is blank' do
    customer = customers(:one)
    customer.shipping_state = ""
    assert_equal(present_address_city_state_zip(customer.shipping_city, customer.shipping_state, customer.shipping_zip_code), "#{customer.shipping_city} #{customer.shipping_zip_code}")
  end

end
