class TicketDataEntriesController < ApplicationController
    
    def index
        @technicians = Technician.all
    end
    
    def show
    end

    def new
      @invoice_options = Invoice.all.map{ |invoice| [ invoice.number ] }
      @technician_options = Technician.all.map{ |technician| [ technician.name ] }
      @ticket_data_entry = TicketDataEntry.new
    end
  
    def edit
    end

    def create
      @ticket_data_entry = TicketDataEntry.new(ticket_data_entry_params)
  
      if @ticket_data_entry.save
        redirect_to root_url, notice: 'Ticket Entry was submitted successfully.'
      else
        render :new
      end
    end

    def update
        respond_to do |format|
          if @ticket_data_entry.update(ticket_data_entry_params)
            format.html { redirect_to @ticket_data_entry, notice: "Ticket data entry was successfully updated." }
            format.json { render :show, status: :ok, location: @ticket_data_entry }
          else
            format.html { render :edit, status: :unprocessable_entity }
            format.json { render json: @ticket_data_entry.errors, status: :unprocessable_entity }
          end
        end
      end

      def destroy
        @ticket_data_entry.destroy
        respond_to do |format|
          format.html { redirect_to ticket_data_entries_url, notice: "Ticket data entry was successfully destroyed." }
          format.json { head :no_content }
        end
      end
  
    private

    def set_ticket_data_entry
        @ticket_data_entry = Ticket_data_entry.find(params[:id])
    end
  
    def ticket_data_entry_params
      params.require(:ticket_data_entry).permit(:customer_name, :phone_number, :invoice_number, :estimate_number, :intake_date, :request_date, :order_type, :discount, :item_number, :item_type, :labor_charge, :material_charge, repair_attributes: [:id, :repair_description, :repair_quote, :repair_charge, :_destroy, task_attributes: [:id, :task_type, :technician_name, :task_time, :task_date, :_destroy]])
    end
  end