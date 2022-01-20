require "application_system_test_case"

class ShopParametersTest < ApplicationSystemTestCase
  setup do
    @shop_parameter = shop_parameters(:one)
  end

  test "visiting the index" do
    visit shop_parameters_url
    assert_selector "h1", text: "Shop Parameters"
  end

  test "creating a Shop parameter" do
    visit shop_parameters_url
    click_on "New Shop Parameter"

    fill_in "Amount", with: @shop_parameter.amount
    fill_in "Name", with: @shop_parameter.name
    click_on "Create Shop parameter"

    assert_text "Shop parameter was successfully created"
    click_on "Back"
  end

  test "updating a Shop parameter" do
    visit shop_parameters_url
    click_on "Edit", match: :first

    fill_in "Amount", with: @shop_parameter.amount
    fill_in "Name", with: @shop_parameter.name
    click_on "Update Shop parameter"

    assert_text "Shop parameter was successfully updated"
    click_on "Back"
  end

  test "destroying a Shop parameter" do
    visit shop_parameters_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Shop parameter was successfully destroyed"
  end
end
