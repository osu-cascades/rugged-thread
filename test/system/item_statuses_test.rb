require "application_system_test_case"

class ItemStatusesTest < ApplicationSystemTestCase

  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:staff)
  end

  test "viewing a list of item statuses" do
    visit item_statuses_path
    assert_selector "h1", text: "Item Statuses"
  end

  test "creating an item status" do
    visit new_item_status_path
    fill_in "Name", with: "Fake New Item Status"
    click_on "Save"
    assert_text "Item status was successfully created"
  end

  test "updating an item status" do
    visit edit_item_status_path(item_statuses(:one))
    fill_in "Name", with: 'Updated Fake Name'
    click_on "Save"
    assert_text "Item status was successfully updated"
  end

  test "creating an item status without a name fails" do
    visit new_item_status_path
    fill_in "Name", with: ""
    click_on "Save"
    assert_text "Name can't be blank"
  end

  test "creating a duplicate item status fails" do
    visit new_item_status_path
    fill_in "Name", with: item_statuses(:one).name
    click_on "Save"
    assert_text "Name has already been taken"
  end

  test "destroying an item status that has no items" do
    visit item_status_path(item_statuses(:itemless))
    click_on 'Delete'
    assert_text "Item status was successfully destroyed"
  end

  test "failing to destroy an item status that has items" do
    visit item_status_path(item_statuses(:one))
    click_on 'Delete'
    assert_text "Cannot delete this item status"
  end

  test "archiving a item status succeeds" do
    visit item_status_path(item_statuses(:one))
    click_on 'Archive'
    assert_text "Item status was successfully archived."
  end

  test "recovering a item status succeeds" do
    visit item_statuses_path
    refute_text item_statuses(:archived).name
    visit item_status_path(item_statuses(:archived))
    click_on 'Recover'
    assert_text 'Item status was successfully recoverd.'
  end

end
