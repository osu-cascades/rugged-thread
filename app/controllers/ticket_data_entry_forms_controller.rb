class TicketDataEntryFormsController < ApplicationController
    
    def index
        @technicians = Technician.all
    end
    
    def show
    end

    def new
      @invoice_options = Invoice.all.map{ |invoice| [ invoice.number ] }
      @technician_options = Technician.all.map{ |technician| [ technician.name ] }
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
        :customer_name, :phone_number, :invoice_number, :estimate_number,
        :intake_date, :request_date, :order_type, :discount, :item_number,
        :item_type, :labor_charge, :material_charge,
        repairs: [:id, :notes, :quote, :charge, :_destroy,
          tasks: [:id, :task_type_name, :technician_name, :time, :date, :_destroy]])
    end

end
