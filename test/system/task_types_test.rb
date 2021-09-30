require "application_system_test_case"

class TaskTypesTest < ApplicationSystemTestCase
  setup do
    @task_type = task_types(:one)
  end

  test "visiting the index" do
    visit task_types_url
    assert_selector "h1", text: "Task Types"
  end

  test "creating a Task type" do
    visit task_types_url
    click_on "New Task Type"

    fill_in "Name", with: @task_type.name
    click_on "Create Task type"

    assert_text "Task type was successfully created"
    click_on "Back"
  end

  test "updating a Task type" do
    visit task_types_url
    click_on "Edit", match: :first

    fill_in "Name", with: @task_type.name
    click_on "Update Task type"

    assert_text "Task type was successfully updated"
    click_on "Back"
  end

  test "destroying a Task type" do
    visit task_types_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Task type was successfully destroyed"
  end
end
