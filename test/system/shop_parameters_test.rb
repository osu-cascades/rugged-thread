require "application_system_test_case"

class ShopParametersTest < ApplicationSystemTestCase

  include Devise::Test::IntegrationHelpers

  setup do
    @shop_parameter = shop_parameters(:one)
    sign_in users(:staff)
  end

  test "visiting the index" do
    visit shop_parameters_path
    assert_selector "h1", text: "Shop Parameters"
  end

  test "creating a Shop parameter" do
    visit shop_parameters_path
    click_on "New Shop Parameter"

    fill_in "Amount", with: @shop_parameter.amount
    fill_in "Name", with: "Fake Shop Param"
    click_on "Create Shop parameter"

    assert_text "Shop parameter was successfully created"
    click_on "Back"
  end

  test "updating a Shop parameter" do
    visit shop_parameters_path
    click_on "Edit", match: :first

    fill_in "Amount", with: @shop_parameter.amount
    fill_in "Name", with: @shop_parameter.name
    click_on "Update Shop parameter"

    assert_text "Shop parameter was successfully updated"
    click_on "Back"
  end

  test "creating a blank Shop parameter name" do
    visit shop_parameters_path
    click_on "New Shop Parameter"

    fill_in "Name", with: ""
    fill_in "Amount", with: @shop_parameter.amount

    click_on "Create Shop parameter"

    assert_text "Name can't be blank"
    click_on "Back"
  end

  test "creating a duplicate Shop parameter name" do
    visit shop_parameters_path
    click_on "New Shop Parameter"

    fill_in "Name", with: @shop_parameter.name
    fill_in "Amount", with: @shop_parameter.amount

    click_on "Create Shop parameter"

    assert_text "Name has already been taken"
    click_on "Back"
  end

  test "destroying a Shop parameter" do
    visit shop_parameters_path
    click_on "Destroy", match: :first

    assert_text "Shop parameter was successfully destroyed"
  end
end
