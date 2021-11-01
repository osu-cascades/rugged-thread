class TicketDataEntryForm
  include ActiveModel::Model

  attr_accessor :customer_name, :phone_number, :invoice_number, :estimate_number, :intake_date, :request_date, :order_type, :discount
  attr_accessor :item_number, :item_type, :labor_charge, :material_charge
  
  attr_accessor :repairs
  attr_accessor :tasks

  def save
    ActiveRecord::Base.transaction do
      ticket = Ticket.new(estimate_number: estimate_number, intake_date: intake_date, request_date: request_date, order_type: order_type, discount: discount, labor_charge: labor_charge, material_charge: material_charge, customer_name: customer_name, phone_number: phone_number)
      add_errors(ticket.errors) if ticket.invalid?
      ticket.save!

      invoice_item = InvoiceItem.new(invoice_number: invoice_number, number: item_number, item_type: item_type)
      add_errors(invoice_item.errors) if invoice_item.invalid?
      invoice_item.save!

      repairs.each do |repair_attributes|
        repair = Repair.new(quote: repair_attributes[quote.to_sym], charge: charge, number: item_number, notes: notes)
        add_errors(repair.errors) if repair.invalid?
        repair.save!
        repair_attributes.tasks.each do |task_attributes|
          task = Task.new(task_type_name: task_type, time: time, date: date, technician_name: technician_name)
          add_errors(task.errors) if task.invalid?
          task.save!
        end
      end
    end
  rescue ActiveRecord::RecordInvalid => exception
    return false
  end

  private

    def add_errors(model_errors)
      model_errors.each do |attribute, message|
        errors.add(attribute, message)
      end
    end
 end
