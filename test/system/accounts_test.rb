require "application_system_test_case"

class AccountsTest < ApplicationSystemTestCase
  setup do
    @account = accounts(:one)
  end

  test "visiting the index" do
    visit accounts_path
    assert_selector "h1", text: "Accounts"
  end

  test "creating a Account" do
    visit accounts_path
    click_on "New Account"

    fill_in "Cost share", with: @account.cost_share
    fill_in "Name", with: @account.name
    fill_in "Turn around", with: @account.turn_around
    click_on "Create Account"

    assert_text "Account was successfully created"
    click_on "Back"
  end

  test "updating a Account" do
    visit accounts_path
    click_on "Edit", match: :first

    fill_in "Cost share", with: @account.cost_share
    fill_in "Name", with: @account.name
    fill_in "Turn around", with: @account.turn_around
    click_on "Update Account"

    assert_text "Account was successfully updated"
    click_on "Back"
  end

  test "destroying a Account" do
    visit accounts_path
    click_on "Destroy", match: :first
    assert_text "Account was successfully destroyed"
  end
end