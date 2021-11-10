class TicketDataEntryForm
  include ActiveModel::Model



  attr_accessor :invoice_number, :intake_date
  attr_accessor :item_number, :labor_charge
  
  attr_accessor :repairs
  attr_accessor :tasks

  def save
    ActiveRecord::Base.transaction do
      ticket = Ticket.new(intake_date: intake_date, labor_charge: labor_charge)
      add_errors(ticket.errors) if ticket.invalid?
      ticket.save!

      repairs.each do |repair_attributes|

        repair = Repair.new(charge: repair_attributes[:charge], number: repair_attributes[:item_number])
        add_errors(repair.errors) if repair.invalid?
        repair.save!
        repair_attributes[:tasks].each do |task_attributes|
          task = Task.new(task_type_name: task_attributes[:task_type_name], time: task_attributes[:time], date: task_attributes[:date], technician_name: task_attributes[:technician_name])
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
