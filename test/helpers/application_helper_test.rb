require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase

  test 'shipping: #present_address_city_state_zip returns zip code if city and state are blank' do
    customer = customers(:one)
    customer.shipping_city = ""
    customer.shipping_state = ""
    assert_equal(present_address_city_state_zip(customer.shipping_city, customer.shipping_state, customer.shipping_zip_code), customer.shipping_zip_code) 
  end

  test 'shipping: #present_address_city_state_zip returns state and zip code if city is blank' do
    customer = customers(:one)
    customer.shipping_city = ""
    assert_equal(present_address_city_state_zip(customer.shipping_city, customer.shipping_state, customer.shipping_zip_code), "#{customer.shipping_state} #{customer.shipping_zip_code}")
  end

  test 'shipping: #present_address_city_state_zip returns city and zip code if state is blank' do
    customer = customers(:one)
    customer.shipping_state = ""
    assert_equal(present_address_city_state_zip(customer.shipping_city, customer.shipping_state, customer.shipping_zip_code), "#{customer.shipping_city} #{customer.shipping_zip_code}")
  end

  test 'billing: #present_address_city_state_zip returns zip code if city and state are blank' do
    customer = customers(:one)
    customer.billing_city = ""
    customer.billing_state = ""
    assert_equal(present_address_city_state_zip(customer.billing_city, customer.billing_state, customer.billing_zip_code), customer.billing_zip_code) 
  end

  test 'billing: #present_address_city_state_zip returns state and zip code if city is blank' do
    customer = customers(:one)
    customer.billing_city = ""
    assert_equal(present_address_city_state_zip(customer.billing_city, customer.billing_state, customer.billing_zip_code), "#{customer.billing_state} #{customer.billing_zip_code}")
  end

  test 'billing: #present_address_city_state_zip returns city and zip code if state is blank' do
    customer = customers(:one)
    customer.billing_state = ""
    assert_equal(present_address_city_state_zip(customer.billing_city, customer.billing_state, customer.billing_zip_code), "#{customer.billing_city} #{customer.billing_zip_code}")
  end

end
