require "application_system_test_case"

class ShopParametersTest < ApplicationSystemTestCase

  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:staff)
  end

  test "visiting the index" do
    visit shop_parameters_path
    assert_selector "h1", text: "Shop Parameters"
  end

  test "creating a shop parameter" do
    visit new_shop_parameter_path
    fill_in "Amount", with: 1
    fill_in "Name", with: "Fake Shop Parameter"
    click_on "Create Shop parameter"
    assert_text "Shop parameter was successfully created"
  end

  test "updating a shop parameter" do
    visit edit_shop_parameter_path(shop_parameters(:one))
    fill_in "Name", with: 'Updated shop parameter'
    click_on "Update Shop parameter"
    assert_text "Shop parameter was successfully updated"
  end

  test "creating a shop parameter with a blank name fails" do
    visit new_shop_parameter_path
    fill_in "Name", with: ""
    fill_in "Amount", with: 1
    click_on "Create Shop parameter"
    assert_text "Name can't be blank"
  end

  test "creating a duplicate shop parameter name fails" do
    visit new_shop_parameter_path
    fill_in "Name", with: shop_parameters(:one).name
    fill_in "Amount", with: 1
    click_on "Create Shop parameter"
    assert_text "Name has already been taken"
    click_on "Back"
  end

  test "destroying a shop parameter" do
    visit shop_parameters_path
    click_on "Destroy", match: :first
    assert_text "Shop parameter was successfully destroyed"
  end
end
