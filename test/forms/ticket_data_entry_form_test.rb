require "test_helper"

class TicketDataEntryFormTest < ActiveSupport::TestCase

  def ticket_data_entry_form
    ticket_data_entry_form = TicketDataEntryForm.new({
      invoice_number: invoices(:one).number,
      estimate_number: 1,
      intake_date: '01/01/21',
      order_type: 'Fake Order Type',
      discount: 1,
      item_number: '1',
      item_type: 'Fake Item Type',
      repair_description: 'Fake Description',
      repair_quote: 1,
      labor_charge: 1,
      material_charge: 1,
      repair_charge: 1,
      task_type: 'First Fake Task Type',
      technician_name: 'First Fake Technician',
      task_time: 1,
      task_date: '12/01/21',
      customer_name: 'Fake Customer',
      phone_number: 'Fake Phone'
    })
  end

  test 'saving creates a ticket, invoice item, repair and task' do
    form = ticket_data_entry_form
    assert_difference [->{ Ticket.count }, ->{ InvoiceItem.count }, ->{ Repair.count }, ->{Task.count}], 1 do
      form.save
    end
  end

end
