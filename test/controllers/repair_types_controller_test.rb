require "test_helper"

class RepairTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @repair_type = repair_types(:one)
  end

  test "should get index" do
    get repair_types_url
    assert_response :success
  end

  test "should get new" do
    get new_repair_type_url
    assert_response :success
  end

  test "should create repair_type" do
    assert_difference('RepairType.count') do
      post repair_types_url, params: { repair_type: { name: @repair_type.name, time_estimate: @repair_type.time_estimate } }
    end

    assert_redirected_to repair_type_url(RepairType.last)
  end

  test "should show repair_type" do
    get repair_type_url(@repair_type)
    assert_response :success
  end

  test "should get edit" do
    get edit_repair_type_url(@repair_type)
    assert_response :success
  end

  test "should update repair_type" do
    patch repair_type_url(@repair_type), params: { repair_type: { name: @repair_type.name, time_estimate: @repair_type.time_estimate } }
    assert_redirected_to repair_type_url(@repair_type)
  end

  test "should destroy repair_type" do
    assert_difference('RepairType.count', -1) do
      delete repair_type_url(@repair_type)
    end

    assert_redirected_to repair_types_url
  end
end
