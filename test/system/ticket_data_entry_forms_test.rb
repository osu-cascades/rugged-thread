require 'application_system_test_case'

class TicketDataEntryFormsTest < ApplicationSystemTestCase

  include Devise::Test::IntegrationHelpers

  setup do
    @brand = brands(:one)
  end

  test 'creating a ticket data entry' do
    sign_in users(:one)
    visit new_ticket_data_entry_form_path
    select '1', from: 'Invoice number'
    fill_in 'Intake date', with: '10/28/21'
    select invoice_items(:one).number, from: 'Item number'
    fill_in 'Labor charge', with: '3'
    within '#repair_0' do
      fill_in 'Charge', with: '6'
      within '#repair_0_task_0' do
        select task_types(:one).name, from: 'Task type name'
        select technicians(:one).name, from: 'Technician name'
        fill_in 'Time', with: '7'
        fill_in 'Date', with: '10/28/21'
      end
      within '#repair_0_task_1' do
        select task_types(:one).name, from: 'Task type name'
        select technicians(:one).name, from: 'Technician name'
        fill_in 'Time', with: '7'
        fill_in 'Date', with: '10/28/21'
      end
    end
    within '#repair_1' do
      fill_in 'Charge', with: '6'
      within '#repair_1_task_0' do
        select task_types(:one).name, from: 'Task type name'
        select technicians(:one).name, from: 'Technician name'
        fill_in 'Time', with: '7'
        fill_in 'Date', with: '10/28/21'
      end
      within '#repair_1_task_1' do
        select task_types(:one).name, from: 'Task type name'
        select technicians(:one).name, from: 'Technician name'
        fill_in 'Time', with: '7'
        fill_in 'Date', with: '10/28/21'
      end
    end
    within '#repair_3' do
      fill_in 'Charge', with: '22'
      within '#repair_3_task_0' do
        select task_types(:one).name, from: 'Task type name'
        select technicians(:one).name, from: 'Technician name'
        fill_in 'Time', with: '37'
        fill_in 'Date', with: '10/28/24'
      end
      within '#repair_3_task_1' do
        select task_types(:one).name, from: 'Task type name'
        select technicians(:one).name, from: 'Technician name'
        fill_in 'Time', with: '8'
        fill_in 'Date', with: '10/28/24'
      end
    end
    within '#repair_4' do
      fill_in 'Charge', with: '4'
      within '#repair_4_task_0' do
        select task_types(:one).name, from: 'Task type name'
        select technicians(:one).name, from: 'Technician name'
        fill_in 'Time', with: '2'
        fill_in 'Date', with: '10/28/22'
      end
      within '#repair_4_task_1' do
        select task_types(:one).name, from: 'Task type name'
        select technicians(:one).name, from: 'Technician name'
        fill_in 'Time', with: '8'
        fill_in 'Date', with: '10/28/22'
      end
    end
    within '#repair_2' do
      fill_in 'Charge', with: '4'
      within '#repair_2_task_0' do
        select task_types(:one).name, from: 'Task type name'
        select technicians(:one).name, from: 'Technician name'
        fill_in 'Time', with: '2'
        fill_in 'Date', with: '10/28/22'
      end
      within '#repair_2_task_1' do
        select task_types(:one).name, from: 'Task type name'
        select technicians(:one).name, from: 'Technician name'
        fill_in 'Time', with: '8'
        fill_in 'Date', with: '10/28/22'
      end
    end
    click_on 'Create Ticket data entry form'
    assert_text 'Ticket Entry was submitted successfully'
  end

end
