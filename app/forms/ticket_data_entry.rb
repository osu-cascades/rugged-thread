class TicketDataEntry
    include ActiveModel::Model
    
    attr_accessor :invoice_number, :estimate_number, :intake_date, :request_date, :order_type, :discount 
    attr_accessor :item_number, :item_type 
    attr_accessor :repair_description, :repair_quote, :labor_charge, :material_charge, :repair_charge 
    attr_accessor :task_type, :technician_name, :task_time, :task_date 
    attr_accessor :customer_name, :phone_number
 
   def save
     ActiveRecord::Base.transaction do
       ticket = Ticket.new(estimate_number: estimate_number, intake_date: intake_date, request_date: request_date, order_type: order_type, discount: discount, repair_description: repair_description, labor_charge: labor_charge, material_charge: material_charge, customer_name: customer_name, phone_number: phone_number)
       add_errors(ticket.errors) if ticket.invalid?
       ticket.save!

       invoice_item = InvoiceItem.new(invoice_number: invoice_number, number: item_number, item_type: item_type)
       add_errors(invoice_item.errors) if invoice_item.invalid?
       invoice_item.save!

       repair = Repair.new(quote: repair_quote, charge: repair_charge, number: item_number)
       add_errors(repair.errors) if repair.invalid?
       repair.save!

       task = Task.new(task_type_name: task_type, time: task_time, date: task_date, technician_name: technician_name)
       add_errors(task.errors) if task.invalid?
       task.save!
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