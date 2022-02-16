require "application_system_test_case"

class DiscountsTest < ApplicationSystemTestCase

  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:staff)
  end

  test "visiting the index shows a table of all discounts, each with a Details link" do
    visit discounts_path
    assert_selector "h1", text: "Discounts"
    assert_selector "#discounts_table"
    assert_link 'Details'
  end

  test "viewing a list of discounts for an item" do
    item = items(:one)
    visit item_path(item)
    assert_text item.discounts.first.standard_discount.name
  end

  test "viewing a discount shows the standard discount name, notes, item brand name and item type name" do
    visit discount_path(discounts(:one))
    assert_text discounts(:one).standard_discount.name
    assert_text discounts(:one).standard_discount.percentage_amount
    assert_text discounts(:one).standard_discount.dollar_amount
    assert_text discounts(:one).item.brand.name
    assert_text discounts(:one).item.item_type.name
  end

  test "creating a discount for an item" do
    visit item_path(items(:one))
    select standard_discounts(:one).name, from: :discount_standard_discount_id
    fill_in "Percentage amount", with: standard_discounts(:one).dollar_amount
    fill_in "Dollar amount", with: standard_discounts(:one).percentage_amount
    click_on "Create Discount"
    assert_text "Discount was successfully created"
  end

  test "Adding an invalid discount redisplays the item view with errors" do
    visit item_path(items(:one))
    fill_in "Percentage amount", with: standard_discounts(:one).dollar_amount
    fill_in "Dollar amount", with: standard_discounts(:one).percentage_amount
    click_on 'Create Discount'
    assert_text 'prohibited this discount from being saved'
  end


  test "updating an invalid discount redisplays the edit view with errors" do
    visit edit_discount_path(discounts(:one))
    select '', from: :discount_standard_discount_id
    click_on "Update Discount"
    assert_text "prohibited this discount from being saved"
  end

end