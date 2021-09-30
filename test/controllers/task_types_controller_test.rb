require "test_helper"

class TaskTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @task_type = task_types(:one)
  end

  test "should get index" do
    get task_types_url
    assert_response :success
  end

  test "should get new" do
    get new_task_type_url
    assert_response :success
  end

  test "should create task_type" do
    assert_difference('TaskType.count') do
      post task_types_url, params: { task_type: { name: @task_type.name } }
    end

    assert_redirected_to task_type_url(TaskType.last)
  end

  test "should show task_type" do
    get task_type_url(@task_type)
    assert_response :success
  end

  test "should get edit" do
    get edit_task_type_url(@task_type)
    assert_response :success
  end

  test "should update task_type" do
    patch task_type_url(@task_type), params: { task_type: { name: @task_type.name } }
    assert_redirected_to task_type_url(@task_type)
  end

  test "should destroy task_type" do
    assert_difference('TaskType.count', -1) do
      delete task_type_url(@task_type)
    end

    assert_redirected_to task_types_url
  end
end
