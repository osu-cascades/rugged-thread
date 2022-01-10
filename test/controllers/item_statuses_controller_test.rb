require "test_helper"

class ItemStatusesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @item_status = item_statuses(:one)
  end

  test "should get index" do
    get item_statuses_url
    assert_response :success
  end

  test "should get new" do
    get new_item_status_url
    assert_response :success
  end

  test "should create item_status" do
    assert_difference('ItemStatus.count') do
      post item_statuses_url, params: { item_status: {  } }
    end

    assert_redirected_to item_status_url(ItemStatus.last)
  end

  test "should show item_status" do
    get item_status_url(@item_status)
    assert_response :success
  end

  test "should get edit" do
    get edit_item_status_url(@item_status)
    assert_response :success
  end

  test "should update item_status" do
    patch item_status_url(@item_status), params: { item_status: {  } }
    assert_redirected_to item_status_url(@item_status)
  end

  test "should destroy item_status" do
    assert_difference('ItemStatus.count', -1) do
      delete item_status_url(@item_status)
    end

    assert_redirected_to item_statuses_url
  end
end
