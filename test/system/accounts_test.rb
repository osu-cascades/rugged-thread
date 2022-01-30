require "application_system_test_case"

class AccountsTest < ApplicationSystemTestCase

  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:staff)
  end

  test "visiting the index" do
    visit accounts_path
    assert_selector "h1", text: "Accounts"
  end

  test "creating a Account" do
    visit new_account_path
    fill_in "Cost share", with: 1
    fill_in "Name", with: "Fake Account Name"
    fill_in "Turn around", with: 2
    click_on "Save"
    assert_text "Account was successfully created"
  end

  test "updating a Account" do
    visit edit_account_path(accounts(:one))
    fill_in "Cost share", with: 1
    fill_in "Name", with: "Fake Account Name"
    fill_in "Turn around", with: 2
    click_on "Save"
    assert_text "Account was successfully updated"
  end

  test "creating a blank Account description" do
    visit new_account_path
    fill_in "Name", with: ""
    fill_in "Cost share", with: 1
    fill_in "Turn around", with: 2
    click_on "Save"
    assert_text "Name can't be blank"
  end

  test "creating a duplicate Account name" do
    visit new_account_path
    fill_in "Name", with: accounts(:one)
    fill_in "Cost share", with: 1
    fill_in "Turn around", with: 2
    click_on "Save"
    assert_text "Name has already been taken"
  end

  test "destroying a Account" do
    visit accounts_path
    click_on "Delete", match: :first
    assert_text "Account was successfully destroyed"
  end
end
