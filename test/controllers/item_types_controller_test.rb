require "test_helper"

class ItemTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @item_type = item_types(:one)
  end

  test "should get index" do
    get item_types_url
    assert_response :success
  end

  test "should get new" do
    get new_item_type_url
    assert_response :success
  end

  test "should create item_type" do
    assert_difference('ItemType.count') do
      post item_types_url, params: { item_type: { component: @item_type.component, name: @item_type.name } }
    end

    assert_redirected_to item_type_url(ItemType.last)
  end

  test "should show item_type" do
    get item_type_url(@item_type)
    assert_response :success
  end

  test "should get edit" do
    get edit_item_type_url(@item_type)
    assert_response :success
  end

  test "should update item_type" do
    patch item_type_url(@item_type), params: { item_type: { component: @item_type.component, name: @item_type.name } }
    assert_redirected_to item_type_url(@item_type)
  end

  test "should destroy item_type" do
    assert_difference('ItemType.count', -1) do
      delete item_type_url(@item_type)
    end

    assert_redirected_to item_types_url
  end
end
