require "test_helper"

class ComplicationTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @complication_type = complication_types(:one)
  end

  test "should get index" do
    get complication_types_url
    assert_response :success
  end

  test "should get new" do
    get new_complication_type_url
    assert_response :success
  end

  test "should create complication_type" do
    assert_difference('ComplicationType.count') do
      post complication_types_url, params: { complication_type: { description: @complication_type.description } }
    end

    assert_redirected_to complication_type_url(ComplicationType.last)
  end

  test "should show complication_type" do
    get complication_type_url(@complication_type)
    assert_response :success
  end

  test "should get edit" do
    get edit_complication_type_url(@complication_type)
    assert_response :success
  end

  test "should update complication_type" do
    patch complication_type_url(@complication_type), params: { complication_type: { description: @complication_type.description } }
    assert_redirected_to complication_type_url(@complication_type)
  end

  test "should destroy complication_type" do
    assert_difference('ComplicationType.count', -1) do
      delete complication_type_url(@complication_type)
    end

    assert_redirected_to complication_types_url
  end
end
