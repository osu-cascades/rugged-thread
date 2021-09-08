require "test_helper"

class ComplicationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @complication = complications(:one)
  end

  test "should get index" do
    get complications_url
    assert_response :success
  end

  test "should get new" do
    get new_complication_url
    assert_response :success
  end

  test "should create complication" do
    assert_difference('Complication.count') do
      post complications_url, params: { complication: { charge: @complication.charge, complication_type_id: @complication.complication_type_id, repair_id: @complication.repair_id, time: @complication.time } }
    end

    assert_redirected_to complication_url(Complication.last)
  end

  test "should show complication" do
    get complication_url(@complication)
    assert_response :success
  end

  test "should get edit" do
    get edit_complication_url(@complication)
    assert_response :success
  end

  test "should update complication" do
    patch complication_url(@complication), params: { complication: { charge: @complication.charge, complication_type_id: @complication.complication_type_id, repair_id: @complication.repair_id, time: @complication.time } }
    assert_redirected_to complication_url(@complication)
  end

  test "should destroy complication" do
    assert_difference('Complication.count', -1) do
      delete complication_url(@complication)
    end

    assert_redirected_to complications_url
  end
end
