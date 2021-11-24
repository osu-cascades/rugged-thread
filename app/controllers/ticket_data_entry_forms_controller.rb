class TicketDataEntryFormsController < ApplicationController
    
    def index
        @technicians = Technician.all
    end
    
    def show
    end

    def new
      @invoice_options = Invoice.all.map{ |invoice| [ invoice.number ] }
      @technician_options = Technician.where("status = 'TRUE'").map{ |technician| [ technician.name ] }
      @task_type_name_options = TaskType.all.map{ |task| [ task.name] }
      @item_number_options = InvoiceItem.all.map{ |item| [ item.number] }
      @ticket_data_entry_form = TicketDataEntryForm.new
    end
  
    def edit
    end

    def create
      @ticket_data_entry_form = TicketDataEntryForm.new(ticket_data_entry_form_params)
      if @ticket_data_entry_form.save
        redirect_to root_url, notice: 'Ticket Entry was submitted successfully.'
      else
        render :new
      end
    end

    def update
        respond_to do |format|
          if @ticket_data_entry_form.update(ticket_data_entry_form_params)
            format.html { redirect_to @ticket_data_entry_form, notice: "Ticket data entry was successfully updated." }
            format.json { render :show, status: :ok, location: @ticket_data_entry_form }
          else
            format.html { render :edit, status: :unprocessable_entity }
            format.json { render json: @ticket_data_entry_form.errors, status: :unprocessable_entity }
          end
        end
      end

      def destroy
        @ticket_data_entry_form.destroy
        respond_to do |format|
          format.html { redirect_to ticket_data_entries_url, notice: "Ticket data entry was successfully destroyed." }
          format.json { head :no_content }
        end
      end
  
    private

    def set_ticket_data_entry_form
        @ticket_data_entry_form = TicketDataEntryForm.find(params[:id])
    end
  
    def ticket_data_entry_form_params
      params.require(:ticket_data_entry_form).permit(
        :invoice_number, :intake_date, :item_number, :labor_charge,
        repairs: [:id, :charge, :_destroy,
          tasks: [:id, :task_type_name, :technician_name, :time, :date, :_destroy]
        ]
      )
    end

end
