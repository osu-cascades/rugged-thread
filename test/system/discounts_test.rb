require "application_system_test_case"

class DiscountsTest < ApplicationSystemTestCase

  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:staff)
  end

  test "visiting the index shows a table of all discounts" do
    visit discounts_path
    assert_selector "h1", text: "Discounts"
    assert_selector "#discounts_table"
  end

  test "viewing a list of discounts for an item" do
    item = items(:one)
    visit item_path(item)
    assert_text item.discounts.first.name
  end

  test "viewing a discount shows the standard discount name, notes, item brand name and item type name" do
    visit discount_path(discounts(:one))
    assert_text discounts(:one).name
    assert_text discounts(:one).price
    assert_text discounts(:one).item.brand.name
    assert_text discounts(:one).item.item_type.name
  end

  test "creating a discount for an item" do
    visit item_path(items(:one))
    select standard_discounts(:one).name, from: :discount_standard_discount_id
    fill_in "Percentage amount", with: 10
    click_on "Add Discount"
    assert_text "Discount was successfully created"
  end

  test "Adding an invalid discount redisplays the item view with errors" do
    visit item_path(items(:one))
    fill_in "Percentage amount", with: standard_discounts(:one).percentage_amount
    fill_in "discount_price", with: standard_discounts(:one).price
    click_on 'Add Discount'
    assert_text 'prohibited this discount from being saved'
  end

  test "updating a discount" do
    visit edit_discount_path(discounts(:one))
    fill_in "Percentage amount", with: ''
    fill_in "Price", with: 3
    click_on "Update Discount"
    assert_text "Discount was successfully updated"
  end

  test "updating an invalid discount redisplays the edit view with errors" do
    visit edit_discount_path(discounts(:one))
    select '', from: :discount_standard_discount_id
    click_on "Update Discount"
    assert_text "prohibited this discount from being saved"
  end

  test "destroying a discount succeeds" do
    visit discount_path(discounts(:one))
    click_on "Delete"
    assert_text "Discount was successfully destroyed"
  end

end
