require "application_system_test_case"

class TicketsTest < ApplicationSystemTestCase
  setup do
    @ticket = tickets(:one)
  end

  test "visiting the index" do
    visit tickets_url
    assert_selector "h1", text: "Tickets"
  end

  test "creating a Ticket" do
    visit tickets_url
    click_on "New Ticket"

    fill_in "Add fee", with: @ticket.add_fee
    fill_in "Invoice", with: @ticket.invoice_id
    fill_in "Repair description", with: @ticket.repair_description
    fill_in "Technician", with: @ticket.technician_id
    fill_in "Technician notes", with: @ticket.technician_notes
    fill_in "Work status", with: @ticket.work_status
    click_on "Create Ticket"

    assert_text "Ticket was successfully created"
    click_on "Back"
  end

  test "updating a Ticket" do
    visit tickets_url
    click_on "Edit", match: :first

    fill_in "Add fee", with: @ticket.add_fee
    fill_in "Invoice", with: @ticket.invoice_id
    fill_in "Repair description", with: @ticket.repair_description
    fill_in "Technician", with: @ticket.technician_id
    fill_in "Technician notes", with: @ticket.technician_notes
    fill_in "Work status", with: @ticket.work_status
    click_on "Update Ticket"

    assert_text "Ticket was successfully updated"
    click_on "Back"
  end

  test "destroying a Ticket" do
    visit tickets_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Ticket was successfully destroyed"
  end
end
