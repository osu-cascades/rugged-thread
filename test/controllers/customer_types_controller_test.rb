require "test_helper"

class CustomerTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @customer_type = customer_types(:one)
  end

  test "should get index" do
    get customer_types_url
    assert_response :success
  end

  test "should get new" do
    get new_customer_type_url
    assert_response :success
  end

  test "should create customer_type" do
    assert_difference('CustomerType.count') do
      post customer_types_url, params: { customer_type: {  } }
    end

    assert_redirected_to customer_type_url(CustomerType.last)
  end

  test "should show customer_type" do
    get customer_type_url(@customer_type)
    assert_response :success
  end

  test "should get edit" do
    get edit_customer_type_url(@customer_type)
    assert_response :success
  end

  test "should update customer_type" do
    patch customer_type_url(@customer_type), params: { customer_type: {  } }
    assert_redirected_to customer_type_url(@customer_type)
  end

  test "should destroy customer_type" do
    assert_difference('CustomerType.count', -1) do
      delete customer_type_url(@customer_type)
    end

    assert_redirected_to customer_types_url
  end
end
