require "application_system_test_case"

class TasksTest < ApplicationSystemTestCase
  setup do
    @task = tasks(:one)
  end

  test "visiting the index" do
    visit tasks_path
    assert_selector "h1", text: "Tasks"
  end

  test "creating a Task" do
    visit tasks_path
    click_on "New Task"

    fill_in "Number", with: @task.number
    fill_in "Task type", with: @task.task_type_id
    fill_in "Technician", with: @task.technician_id
    fill_in "Time", with: @task.time
    click_on "Create Task"

    assert_text "Task was successfully created"
    click_on "Back"
  end

  test "updating a Task" do
    visit tasks_path
    click_on "Edit", match: :first

    fill_in "Number", with: @task.number
    fill_in "Task type", with: @task.task_type_id
    fill_in "Technician", with: @task.technician_id
    fill_in "Time", with: @task.time
    click_on "Update Task"

    assert_text "Task was successfully updated"
    click_on "Back"
  end

  test "destroying a Task" do
    visit tasks_path
    click_on "Destroy", match: :first

    assert_text "Task was successfully destroyed"
  end
end
