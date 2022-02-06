require "application_system_test_case"

class InvoicesTest < ApplicationSystemTestCase

  include Devise::Test::IntegrationHelpers

  setup do
    @invoice = invoices(:one)
    sign_in users(:staff)
  end

  test "visiting the index" do
    visit invoices_path
    assert_selector "h1", text: "Invoices"
  end

  test "creating a Invoice" do
    visit invoices_path
    click_on "New Invoice"

    fill_in "Customer", with: @invoice.customer_id
    fill_in "Date fulfilled", with: @invoice.date_fulfilled
    fill_in "Intake date", with: @invoice.intake_date
    fill_in "Invoice estimate", with: @invoice.invoice_estimate
    fill_in "Invoice total", with: @invoice.invoice_total
    click_on "Create Invoice"

    assert_text "Invoice was successfully created"
    click_on "Back"
  end

  test "updating a Invoice" do
    visit invoices_path
    click_on "Edit", match: :first

    fill_in "Customer", with: @invoice.customer_id
    fill_in "Date fulfilled", with: @invoice.date_fulfilled
    fill_in "Intake date", with: @invoice.intake_date
    fill_in "Invoice estimate", with: @invoice.invoice_estimate
    fill_in "Invoice total", with: @invoice.invoice_total
    click_on "Update Invoice"

    assert_text "Invoice was successfully updated"
    click_on "Back"
  end

  test "destroying a Invoice" do
    skip
    visit invoices_path
    click_on "Destroy", match: :first

    assert_text "Invoice was successfully destroyed"
  end
end
