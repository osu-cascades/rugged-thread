require "test_helper"

class ShopParametersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @shop_parameter = shop_parameters(:one)
  end

  test "should get index" do
    get shop_parameters_url
    assert_response :success
  end

  test "should get new" do
    get new_shop_parameter_url
    assert_response :success
  end

  test "should create shop_parameter" do
    assert_difference('ShopParameter.count') do
      post shop_parameters_url, params: { shop_parameter: { amount: @shop_parameter.amount, name: @shop_parameter.name } }
    end

    assert_redirected_to shop_parameter_url(ShopParameter.last)
  end

  test "should show shop_parameter" do
    get shop_parameter_url(@shop_parameter)
    assert_response :success
  end

  test "should get edit" do
    get edit_shop_parameter_url(@shop_parameter)
    assert_response :success
  end

  test "should update shop_parameter" do
    patch shop_parameter_url(@shop_parameter), params: { shop_parameter: { amount: @shop_parameter.amount, name: @shop_parameter.name } }
    assert_redirected_to shop_parameter_url(@shop_parameter)
  end

  test "should destroy shop_parameter" do
    assert_difference('ShopParameter.count', -1) do
      delete shop_parameter_url(@shop_parameter)
    end

    assert_redirected_to shop_parameters_url
  end
end
