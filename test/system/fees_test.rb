require "application_system_test_case"

class FeesTest < ApplicationSystemTestCase

  include Devise::Test::IntegrationHelpers
  include ActionView::Helpers::NumberHelper

  setup do
    sign_in users(:staff)
  end

  test "visiting the index shows a table of all fees" do
    visit fees_path
    assert_selector "h1", text: "Fees"
    assert_selector "#fees_table"
  end

  test "viewing a list of fees for an item" do
    item = items(:one)
    visit item_path(item)
    assert_text item.fees.first.name
  end

  test "viewing a fee shows the standard fee name, item brand name and item type name" do
    visit fee_path(fees(:one))
    assert_text fees(:one).name
    assert_text fees(:one).item.brand.name
    assert_text fees(:one).item.item_type.name
    assert_text fees(:one).price.format
  end

  test "creating a fee for an item" do
    visit item_path(items(:one))
    select standard_fees(:one).name, from: :fee_standard_fee_id
    fill_in "fee_price", with: standard_fees(:one).price
    click_on "Add Fee"
    assert_text "Fee was successfully created"
  end

  test "Adding an invalid fee redisplays the item view with errors" do
    visit item_path(items(:one))
    click_on 'Add Fee'
    assert_text 'prohibited this fee from being saved'
  end

  test "updating a fee" do
    visit edit_fee_path(fees(:one))
    select standard_fees(:one).name, from: :fee_standard_fee_id
    click_on "Update Fee"
    assert_text "Fee was successfully updated"
  end

  test "updating an invalid fee redisplays the edit view with errors" do
    visit edit_fee_path(fees(:one))
    select '', from: :fee_standard_fee_id
    click_on "Update Fee"
    assert_text "prohibited this fee from being saved"
  end

end
