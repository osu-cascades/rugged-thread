require "application_system_test_case"

class InvoiceItemsTest < ApplicationSystemTestCase

  include Devise::Test::IntegrationHelpers

  setup do
    @invoice_item = invoice_items(:one)
    sign_in users(:staff)
  end

  test "visiting the index" do
    visit invoice_items_path
    assert_selector "h1", text: "Invoice Items"
  end

  test "creating a Invoice item" do
    visit invoice_items_path
    click_on "New Invoice Item"

    fill_in "Description", with: @invoice_item.description
    fill_in "Invoice", with: @invoice_item.invoice_id
    click_on "Create Invoice item"

    assert_text "Invoice item was successfully created"
    click_on "Back"
  end

  test "updating a Invoice item" do
    visit invoice_items_path
    click_on "Edit", match: :first

    fill_in "Description", with: @invoice_item.description
    fill_in "Invoice", with: @invoice_item.invoice_id
    click_on "Update Invoice item"

    assert_text "Invoice item was successfully updated"
    click_on "Back"
  end

  test "destroying a Invoice item" do
    skip
    visit invoice_items_path
    click_on "Destroy", match: :first

    assert_text "Invoice item was successfully destroyed"
  end
end
