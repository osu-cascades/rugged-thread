require 'application_system_test_case'

class TicketDataEntryFormsTest < ApplicationSystemTestCase

  include Devise::Test::IntegrationHelpers

  setup do
    @brand = brands(:one)
  end

  test 'creating a ticket data entry' do
    sign_in users(:one)
    visit new_ticket_data_entry_form_path
    fill_in 'Customer name', with: 'Fake Customer'
    fill_in 'Phone number', with: '123 1234'
    select '1', from: 'Invoice number'
    fill_in 'Estimate number', with: '1'
    fill_in 'Intake date', with: '10/28/21'
    fill_in 'Request date', with: '10/28/21'
    fill_in 'Order type', with: 'Fake Order Type'
    fill_in 'Discount', with: '2'
    fill_in 'Item number', with: '1'
    fill_in 'Item type', with: 'Fake Item Type'
    fill_in 'Labor charge', with: '3'
    fill_in 'Material charge', with: '4'
    within '#repair_0' do
      fill_in 'Description', with: 'Fake Description'
      fill_in 'Quote', with: '5'
      fill_in 'Charge', with: '6'
      within '#repair_0_task_0' do
        fill_in 'Task type name', with: 'Fake task type'
        select technicians(:one).name, from: 'Technician name'
        fill_in 'Time', with: '7'
        fill_in 'Date', with: '10/28/21'
      end
      within '#repair_0_task_1' do
        fill_in 'Task type name', with: 'Fake task type'
        select technicians(:one).name, from: 'Technician name'
        fill_in 'Time', with: '7'
        fill_in 'Date', with: '10/28/21'
      end
    end
    within '#repair_1' do
      fill_in 'Description', with: 'Fake Description'
      fill_in 'Quote', with: '5'
      fill_in 'Charge', with: '6'
      within '#repair_1_task_0' do
        fill_in 'Task type name', with: 'Fake task type'
        select technicians(:one).name, from: 'Technician name'
        fill_in 'Time', with: '7'
        fill_in 'Date', with: '10/28/21'
      end
      within '#repair_1_task_1' do
        fill_in 'Task type name', with: 'Fake task type'
        select technicians(:one).name, from: 'Technician name'
        fill_in 'Time', with: '7'
        fill_in 'Date', with: '10/28/21'
      end
    end
    click_on 'Create Ticket data entry form'
    assert_text 'Ticket Entry was submitted successfully'
  end

end
