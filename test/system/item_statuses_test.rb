require "application_system_test_case"

class ItemStatusesTest < ApplicationSystemTestCase

  include Devise::Test::IntegrationHelpers

  setup do
    @item_status = item_statuses(:one)
    sign_in users(:one)
  end

  test "visiting the index" do
    visit item_statuses_url
    assert_selector "h1", text: "Item Statuses"
  end

  test "creating a Item status" do
    visit item_statuses_url
    click_on "New Item Status"

    fill_in "Name", with: "Fake New Item"

    click_on "Create Item status"

    assert_text "Item status was successfully created"
    click_on "Back"
  end

  test "updating a Item status" do
    visit item_statuses_url
    click_on "Edit", match: :first

    fill_in "Name", with: @item_status.name

    click_on "Update Item status"

    assert_text "Item status was successfully updated"
    click_on "Back"
  end

  test "creating a blank Item Status" do
    visit item_statuses_url
    click_on "New Item Status"

    fill_in "Name", with: ""
    click_on "Create Item status"

    assert_text "Name can't be blank"
    click_on "Back"
  end

  test "creating a duplicate Item Status" do
    visit item_statuses_url
    click_on "New Item Status"

    fill_in "Name", with: @item_status.name
    click_on "Create Item status"

    assert_text "Name has already been taken"
    click_on "Back"
  end

  test "destroying a Item status" do
    visit item_statuses_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Item status was successfully destroyed"
  end
end
